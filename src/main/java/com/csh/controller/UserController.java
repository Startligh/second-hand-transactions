package com.csh.controller;

import com.csh.pojo.*;
import com.csh.service.*;
import com.csh.util.*;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.*;

@Controller
public class UserController {

    @Autowired
    ShowPicService showPicService;

    @Autowired
    UserService userService;

    @Autowired
    LoginService loginService;

    @Autowired
    ProductService productService;

    @Autowired
    ShopcarService shopcarService;

    @Autowired
    OrdersService ordersService;

    @Autowired
    DynamicService dynamicService;

    /**
     * 前往首页
     * */
    @RequestMapping("toShowIndex")
    public String toShowIndex(HttpSession session, Model model) {
        //图片展示、得到置顶且展示的图片
        List<ShowPic> picList = showPicService.getShowPicWithTop();
        //将置顶图放入map中
        Map<Integer, ShowPic> showPicMap = new HashMap<Integer, ShowPic>();
        for(ShowPic showpic : picList) {
            showPicMap.put(showpic.getPicId(), showpic);
        }
        List<ShowPic> showPicList = showPicService.getShowPicWithShow();//再得到所有展示图片
        for (int i = 0; i < showPicList.size(); i++) {
            if(showPicMap.get(showPicList.get(i).getPicId()) == null) {//picList里面没有
                picList.add(showPicList.get(i));
            }
        }
        model.addAttribute("picList", picList);

        //最新发布的商品（查找4个）
        model.addAttribute("count", 0);
        model.addAttribute("keyWord", "newest");
        return "showIndex";
    }

    /**
     * 前往注册页
     * */
    @RequestMapping("toRegister")
    public String toRegister() {
        return "register";
    }

    /**
     * 检测帐号可用注册性
     * */
    @ResponseBody
    @RequestMapping(value = "checkUno", produces = { "text/html;charset=utf-8" })
    public String checkUno(String uno) {
        JSONObject jsonObject = new JSONObject();
        if(userService.selectUserByUno(uno) == null && loginService.selectLogin(uno) == null) {
            jsonObject.put("code", 200);
            jsonObject.put("msg", true);
        } else {
            jsonObject.put("code", 500);
            jsonObject.put("msg", "帐号不可用");
        }
        return jsonObject.toString();
    }

    /**
     * 注册请求
     * */
    @ResponseBody
    @RequestMapping(value = "register", produces = { "text/html;charset=utf-8" })
    public String register(String uno, String upassword, String surepwd, Model model) {
        JSONObject jsonObject = new JSONObject();
        Login login = new Login();
        login.setLno(uno);
        login.setLpassword(upassword);
        login.setRolecode("2");
        if(upassword.equals(surepwd) && userService.addUser(uno,upassword,"white") && loginService.addLogin(login)) {
            jsonObject.put("code", 200);
            jsonObject.put("msg", true);
        } else {
            jsonObject.put("code", 500);
            jsonObject.put("msg", "注册失败");
        }
        return jsonObject.toString();
    }

    /**
     * 前往个人信息修改页
     * */
    @RequestMapping("toUserMsgChange")
    public String toUserMsgChange(HttpSession session, Model model) {
        String uno = (String)session.getAttribute(Constants.USER_NO);
        User user = userService.selectUserByUno(uno);
        model.addAttribute("user", user);
        return "userMsgChange";
    }

    /**
     * 修改个人信息的提交
     * */
    @RequestMapping("/userMsgSure")
    public String userMsgSure(@RequestParam(value = "file") CommonsMultipartFile file , User user, HttpServletRequest request, Model model, HttpSession session) throws IOException {
        //获取文件名 : file.getOriginalFilename();
        if(user != null) {
            if(!"".equals(file.getOriginalFilename())) {//上传的图片文件不为空
                String uploadFileName =UploadPic.uploadPic(file, "headPhoto", request);
                user.setUpricture(uploadFileName);
                session.setAttribute(Constants.USER_PHOTO, uploadFileName);
            }
            session.setAttribute(Constants.USER_NAME, user.getUname());
            userService.updateUserbyuno(user);
            session.setAttribute(Constants.USER_SESSION, userService.selectUserByUno(user.getUno()));
            return toUserMsg(user.getUno(), model, session);
        }
        return toUserMsgChange(session, model);
    }

    /**
     * 前往用户详情页
     * */
    @RequestMapping("toUserMsg")
    public String toUserMsg(String uno, Model model, HttpSession session) {
        //从session中获得user
        User self = (User) session.getAttribute(Constants.USER_SESSION);//得到当前登录用户
        if(!self.getUno().equals(uno)) {//uno != "从session中找到的uno"，判断是否是自己
            //查看他人
            User user = userService.selectUserByUno(uno);
            if(user != null) {
                user.setUpassword(null);
                user.setUbalance(0.0f);
                model.addAttribute("user", user);
                model.addAttribute("keyWord", "user_" + user.getUno());
                model.addAttribute("count", 0);
                model.addAttribute("msg", "differentUser");
                //查询该uno的发布商品
                List<Product> products = userService.selectProductByUno(uno);
                model.addAttribute("products", products);
            }
        } else {//查看自己
            toUserHome(uno, model);
        }
        return "userMsg";
    }

    /**
     * 前往个人详情页
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("home")
    public String home(Model model, HttpServletRequest request) {
        return toUserHome((String) request.getSession().getAttribute(Constants.USER_NO), model);
    }

    /**
     * 前往个人详情页
     * */
    @RequestMapping("toUserHome")
    public String toUserHome(String uno, Model model) {
        User user = userService.selectUserByUno(uno);
        user.setUpassword(null);
        model.addAttribute("user", user);
        //个人信息未完善
        String msg = "请完善您的";
        if("noUserName".equals(user.getUname())) {
            msg += "用户名！";
        }
        if(user.getUsex() == null) {
            msg += "性别！";
        }
        if(user.getUaddress() == null) {
            msg += "地址！";
        }
        if(user.getUtel() == null) {
            msg += "联系方式！";
        }
        if(!"请完善您的".equals(msg)) {
            model.addAttribute("msg", "perfectInfo");
            model.addAttribute("perfectInfo", msg);
        }
        //查询该uno的发布商品
        List<Product> products = userService.selectProductByUno(uno);
        model.addAttribute("products", products);
        return "userMsg";
    }

    /**
     * 获得用户头像文件名
     * @param uno
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getUserHP", produces = { "text/html;charset=utf-8" })
    public String getUserHP(String uno) {
        User user = userService.selectUserByUno(uno);
        JSONObject jsonObject = new JSONObject();
        if(user == null) {
            jsonObject.put("code", 500);
        } else {
            jsonObject.put("code", 200);
            jsonObject.put("userHP", user.getUpricture());
            jsonObject.put("userName", user.getUname());
        }
        return jsonObject.toString();
    }

    /**
     * 前往密码更改页
     * */
    @RequestMapping("toUpdatePassword")
    public String toUpdatePassword() {
        return "updatepassword";
    }

    /**
     * 验证旧密码
     * */
    @ResponseBody
    @RequestMapping(value = "checkOldPwd", produces = { "text/html;charset=utf-8" })
    public String checkOldPwd(String oldPwd, String uno) {
        System.out.println("oldPwd:" + oldPwd + "   uno:" + uno);
        User user = userService.selectUserByUno(uno);
        JSONObject jsonObject = new JSONObject();
        if(user.getUpassword().equals(oldPwd)) {
            jsonObject.put("msg", true);
        } else {
            jsonObject.put("msg", "密码错误");
        }
        return jsonObject.toString();
    }

    /**
     * 修改密码的提交
     * */
    @ResponseBody
    @RequestMapping(value = "changePwd", produces = { "text/html;charset=utf-8" })
    public String changePwd(User user) {
        System.out.println(user);
        JSONObject jsonObject = new JSONObject();
        if(!"".equals(user.getUpassword()) && userService.updateUpassword(user) && loginService.updateLoginByUser(user)) {
            jsonObject.put("msg", true);
        } else {
            jsonObject.put("msg", "更改失败，请重新修改后提交");
        }
        return jsonObject.toString();
    }

    /**
     * 前往添加商品页
     * */
    @RequestMapping("toAddMyProduct")
    public String toAddProduct(String uno, Model model) {
        model.addAttribute("msg", "添加属于你的商品");
        return "addProduct";
    }

    /**
     * 添加商品
     */
    @RequestMapping("addProduct")
    public String addProduct(Model model, @RequestParam(value = "file") CommonsMultipartFile file , Product product, HttpServletRequest request) throws IOException {
        if(product != null) {
            //文件名不为空字符
            if(!"".equals(file.getOriginalFilename())) {
                product.setPpricture(UploadPic.uploadPic(file, "productPhoto" ,request));
            } else {
                product.setPpricture("noProductPhoto");
            }
            //表中商品编号自增没设置，就这么写
            product.setPno(String.valueOf(new Integer(productService.getMaxPno()) + 1));
            System.out.println(product);
            if(productService.addProduct(product)) {//增加到商品列表
                model.addAttribute("product", product);
                return "productMsg";
            }
        }
        model.addAttribute("msg", "信息上传失败");
        return "redirect:/toAddMyProduct";
    }

    /**
     * 前往更改商品信息（是商品持有人修改信息，并且是未交易商品）
     * */
    @RequestMapping("toUpdateProduct")
    public String updateProduct(String pno, HttpSession session, Model model) {
        System.out.println("pno：" + pno);
        Product product = productService.selectProductByPno(pno);
        model.addAttribute("product", product);
        String uno = (String)session.getAttribute(Constants.USER_NO);
        if(product != null && product.getUno().equals(uno)) {//是商品持有人修改信息
            model.addAttribute("msg", "修改商品信息");
            return "addProduct";
        } else {//不允许修改
            return "productMsg";
        }
    }

    /**
     * 修改商品信息的提交
     * */
    @RequestMapping("updateProduct")
    public String updateProduct(Model model, @RequestParam(value = "file") CommonsMultipartFile file , Product product, HttpServletRequest request) throws IOException {
        System.out.println(product);
        if(!"".equals(file.getOriginalFilename())) {//文件名不为空
            product.setPpricture(UploadPic.uploadPic(file, "productPhoto" ,request));
        }
        productService.updateProductByPno(product);
        //重新获得商品信息
        model.addAttribute("product", productService.selectProductByPno(product.getPno()));
        return "productMsg";
    }

    /**
     * 前往商品详情页
     * */
    @RequestMapping("toProductMsg")
    public String toProductMsg(String pno, Model model) {
        Product product = productService.selectProductByPno(pno);
        model.addAttribute("product", product);
        return "productMsg";
    }

    /**
     * 查询用户自己发布的所有商品,Ajax请求
     * */
    @ResponseBody
    @RequestMapping(value = "getMyProducts", produces = { "text/html;charset=utf-8" })
    public String getMyProducts(String uno) {
        System.out.println(uno);
        JSONObject jsonObject = new JSONObject();
        if(!"".equals(uno)) {
            jsonObject.put("code", 200);
            jsonObject.put("msg", "success");
            List<Product> products = productService.selectProductsByUno(uno);
            jsonObject.put("count", products.size());
            jsonObject.put("data", products);
        } else {
            jsonObject.put("code", 500);
        }
        return jsonObject.toString();
    }

    /**
     * 删除商品的异步请求
     * */
    @ResponseBody
    @RequestMapping(value = "delProduct", produces = { "text/html;charset=utf-8" })
    public String delProduct(String pno) {
        JSONObject jsonObject = new JSONObject();
        System.out.println("被删除的商品编号为：" + pno);
        if(pno != null && !"".equals(pno) && productService.deleteProductByPno(pno)) {
            jsonObject.put("code", 200);
            jsonObject.put("msg", true);
        } else {
            jsonObject.put("code", 500);
            jsonObject.put("msg", "删除失败");
        }
        System.out.println(jsonObject);
        return jsonObject.toString();
    }

    /**
     * 前往搜索页的请求
     * */
    @RequestMapping("toSearch")
    public String toSearch(String keyWord, Model model) {
        model.addAttribute("count", 0);
        model.addAttribute("keyWord", keyWord);
        return "productList";
    }

    /**
     * 请求商品的ajax
     * */
    private static final int step = 4;//每次查询的步长
    @ResponseBody
    @RequestMapping(value = "searchProduct", produces = { "text/html;charset=utf-8" })
    public String searchProduct(int count, String keyWord) {
        System.out.println("count:" + count + "    keyWord:" + keyWord);
        JSONObject jsonObject = new JSONObject();
        List<Product> products = null;
        if(keyWord != null && count >= 0) {
            if("newest".equals(keyWord) || "随便看看".equals(keyWord) || "最新发布".equals(keyWord)) {
                if(count >= 0) {
                    products = productService.getNewestProducts(count, count + step);
                }
            } else if(keyWord.contains("user")) {//查看他人用户下的商品列表
                int index = keyWord.lastIndexOf("_") + 1;
                if(index != -1) {
                    keyWord = keyWord.substring(index);
                    products = productService.selectProductsByOtherUno(keyWord, count, count + step);
                }
            } else {//搜索的商品列表
                products = productService.selectProductsByKeyWord(keyWord, count, count + step);
            }
        }
        //检测查询出来的商品列表是否为空
        if(products != null && products.size() > 0) {
            jsonObject.put("newCount", count + step);
            jsonObject.put("data", products);
        } else {
            jsonObject.put("newCount", count);
        }
        System.out.println(jsonObject);
        return jsonObject.toString();
    }

    /**
     * 商品是否在购物车的查询请求
     * */
    @ResponseBody
    @RequestMapping(value = "checkShopCarByPno", produces = { "text/html;charset=utf-8" })
    public String checkShopCarByPno(String pno, HttpSession session) {
        String uno = (String)session.getAttribute(Constants.USER_NO);
        System.out.println("pno:" + pno + "uno:   " + uno);
        JSONObject jsonObject = new JSONObject();
        if(pno != null && !"".equals(pno)
                && uno != null && !"".equals(uno)
                && shopcarService.selectUnoCarByPno(pno, uno) != null) {
            jsonObject.put("msg", true);
        } else {
            jsonObject.put("msg", false);
        }
        return jsonObject.toString();
    }

    /**
     * 商品添加购物车的ajax请求
     * */
    @ResponseBody
    @RequestMapping(value = "addToShopcar", produces = { "text/html;charset=utf-8" })
    public String addToShopcar(String pno, String sno, HttpSession session) {
        String uno = (String)session.getAttribute(Constants.USER_NO);
        System.out.println("pno:" + pno + "uno:   " + uno + "   sno:" + sno);
        JSONObject jsonObject = new JSONObject();
        //传入参数可用，并且不是这个uno发布的商品pno
        if(pno != null && !"".equals(pno)
                && uno != null && !"".equals(uno)
                && sno != null && !"".equals(sno)
                && productService.selectUnoProductByPno(uno, pno) == null
                && shopcarService.insertShopcar(pno, uno, sno)) {
            jsonObject.put("msg", true);
        } else {
            jsonObject.put("msg", false);
        }
        return jsonObject.toString();
    }

    /**
     * 商品从购物车删除的Ajax请求
     * */
    @ResponseBody
    @RequestMapping(value = "delFromShopcar", produces = { "text/html;charset=utf-8" })
    public String delFromShopcar(String pno, HttpSession session) {
        String uno = (String)session.getAttribute(Constants.USER_NO);
        System.out.println("pno:" + pno + "uno:   " + uno);
        JSONObject jsonObject = new JSONObject();
        if(pno != null && !"".equals(pno)
                && uno != null && !"".equals(uno)
                && shopcarService.deleteUnoShopcarByPno(pno, uno)) {
            jsonObject.put("msg", true);
        } else {
            jsonObject.put("msg", false);
        }
        return jsonObject.toString();
    }

    /**
     * 前往购物车管理页面
     * */
    @RequestMapping("toShopcar")
    public String toShopcar() {
        return "shopcar";
    }

    /**
     * 获得购物车信息的ajax请求
     * */
    @ResponseBody
    @RequestMapping(value = "getMyShopcar", produces = { "text/html;charset=utf-8" })
    public String getMyShopcar(String uno) {
        System.out.println(uno);
        JSONObject jsonObject = new JSONObject();
        if(!"".equals(uno)) {
            jsonObject.put("code", 200);
            jsonObject.put("msg", "success");
            List<Shopcar> shopcars = shopcarService.selectShopcarsByUno(uno);
            jsonObject.put("count", shopcars.size());
            jsonObject.put("data", shopcars);
        } else {
            jsonObject.put("code", 500);
        }
        return jsonObject.toString();
    }

    /**
     * 检查商品有无被购买的ajax请求
     * 返回true:未购买，反之
     * */
    @ResponseBody
    @RequestMapping(value = "checkOrderByPno", produces = { "text/html;charset=utf-8" })
    public String checkOrderByPno(String pno) {
        System.out.println(pno);
        JSONObject jsonObject = new JSONObject();
        if(!"".equals(pno) && ordersService.selectOrdersByPno(pno).size() <= 0) {//
            jsonObject.put("msg", true);
        } else {
            jsonObject.put("msg", false);
        }
        return jsonObject.toString();
    }

    /**
     * 立即购买的请求，查询商品的详细信息，然后前往订单详情页
     * */
    @RequestMapping("buy")
    public String buy(String pno, HttpSession session, Model model) {
        System.out.println("pno:" + pno);
        Orders orders = new Orders();
        Product product = productService.selectProductByPno(pno);
        model.addAttribute("product", product);
        orders.setSno(product.getUno());
        orders.setBno((String)session.getAttribute(Constants.USER_NO));
        orders.setPno(pno);
        orders.setOdate(new Date());
        orders.setStats(500);
        orders.setOno(ordersService.selectMaxOno() + 1);
        model.addAttribute("order", orders);
        return "ordersDetail";
    }

    /**
     * 确认购买下单的请求
     * */
    @RequestMapping("sureOrder")
    public String sureOrder(Orders orders, Model model, HttpSession session) {
        System.out.println(orders);
        orders.setOdate(new Date());
        ordersService.insertOrder(orders);
        Dynamic dynamic = new Dynamic();
        dynamic.setDtype(UserMethod.getStringTime() + " 提交购买订单");
        dynamic.setPno(orders.getPno());
        dynamic.setUno(orders.getBno());
        dynamicService.insertDynamic(dynamic);
        return toOrderDetail(orders.getOno(), model, session);
    }

    /**
     * 前往订单管理页面
     * */
    @RequestMapping("mangeMyOrder")
    public String mangeMyOrder() {
        return "orderList";
    }

    /**
     * 查询uno下所有的订单信息
     * */
    @ResponseBody
    @RequestMapping(value = "getMyOrders", produces = { "text/html;charset=utf-8" })
    public String getMyOrders(String uno) {
        System.out.println(uno);
        JSONObject jsonObject = new JSONObject();
        if(uno != null && !"".equals(uno)) {
            jsonObject.put("code", 200);
            jsonObject.put("msg", "success");
            List<Orders> orders = ordersService.selectOrdersByUno(uno);
            jsonObject.put("count", orders.size());
            jsonObject.put("data", orders);
        } else {
            jsonObject.put("code", 500);
        }
        return jsonObject.toString();
    }

    /**
     * 查询uno下所有的购买订单
     * */
    @ResponseBody
    @RequestMapping(value = "getMyBuy", produces = { "text/html;charset=utf-8" })
    public String getMyBuy(String uno) {
        System.out.println(uno);
        JSONObject jsonObject = new JSONObject();
        if(uno != null && !"".equals(uno)) {
            jsonObject.put("code", 200);
            jsonObject.put("msg", "success");
            List<Orders> orders = ordersService.selectOrdersByBno(uno);
            jsonObject.put("count", orders.size());
            jsonObject.put("data", orders);
        } else {
            jsonObject.put("code", 500);
        }
        return jsonObject.toString();
    }

    /**
     * 查询uno下所有的售出订单
     * */
    @ResponseBody
    @RequestMapping(value = "getMySale", produces = { "text/html;charset=utf-8" })
    public String getMySale(String uno) {
        System.out.println(uno);
        JSONObject jsonObject = new JSONObject();
        if(uno != null && !"".equals(uno)) {
            jsonObject.put("code", 200);
            jsonObject.put("msg", "success");
            List<Orders> orders = ordersService.selectOrdersBySno(uno);
            jsonObject.put("count", orders.size());
            jsonObject.put("data", orders);
        } else {
            jsonObject.put("code", 500);
        }
        return jsonObject.toString();
    }

    /**
     * 前往订单详情页的请求
     * */
    @RequestMapping("toOrderDetail")
    public String toOrderDetail(int ono, Model model, HttpSession session) {
        System.out.println(ono);
        String uno = (String)session.getAttribute(Constants.USER_NO);
        //查询ono的订单
        Orders orders = ordersService.selectOrderByOnoWithSave(ono, uno);
        if(orders != null) {
            model.addAttribute("order", orders);
        }
        return "ordersDetail";
    }

    /**
     * 确认订单的ajax请求
     * */
    @ResponseBody
    @RequestMapping(value = "sureTheOrder", produces = { "text/html;charset=utf-8" })
    public String sureTheOrder(String ono) {
        System.out.println("ono: " + ono);
        JSONObject jsonObject = new JSONObject();
        if(!"".equals(ono) && ordersService.updateOrdersStats(1, ono)) {
            Orders orders = ordersService.selectOrderByOno(ono);
            Dynamic dynamic = new Dynamic();
            dynamic.setPno(orders.getPno());
            dynamic.setUno(orders.getBno());
            dynamic.setDtype(UserMethod.getStringTime() + " 确认订单");
            dynamicService.insertDynamic(dynamic);
            jsonObject.put("msg", true);
        } else {
            jsonObject.put("msg", false);
        }
        return jsonObject.toString();
    }

    /**
     * 取消订单的ajax请求
     * */
    @ResponseBody
    @RequestMapping(value = "delTheOrder", produces = { "text/html;charset=utf-8" })
    public String delTheOrder(String ono) {
        System.out.println("ono: " + ono);
        JSONObject jsonObject = new JSONObject();
        if(!"".equals(ono) && ordersService.updateOrdersStats(0, ono)) {
            jsonObject.put("msg", true);
            Orders orders = ordersService.selectOrderByOno(ono);
            Dynamic dynamic = new Dynamic();
            dynamic.setPno(orders.getPno());
            dynamic.setUno(orders.getBno());
            dynamic.setDtype(UserMethod.getStringTime() + " 取消订单");
            dynamicService.insertDynamic(dynamic);
        } else {
            jsonObject.put("msg", false);
        }
        return jsonObject.toString();
    }

    /**
     * 检查动态数量的ajax请求
     * */
    @ResponseBody
    @RequestMapping(value = "checkNewDynamic", produces = { "text/html;charset=utf-8" })
    public String checkNewDynamic(HttpSession session) {
        String uno = (String)session.getAttribute(Constants.USER_NO);
        JSONObject jsonObject = new JSONObject();
        if(uno != null && !"".equals(uno)) {
            jsonObject.put("msg", true);
            jsonObject.put("count", dynamicService.selectCountOfNewDynamicByUno(uno));
        } else {
            jsonObject.put("msg", false);
        }
        return jsonObject.toString();
    }

    /**
     * 前往消息页的请求
     * */
    @RequestMapping("myDynamic")
    public String toMyDynamic() {
        return "myDynamic";
    }

    /**
     * 检查动态数量的ajax请求
     * */
    @ResponseBody
    @RequestMapping(value = "getMyDynamic", produces = { "text/html;charset=utf-8" })
    public String getMyDynamic(String uno) {
        System.out.println(uno);
        JSONObject jsonObject = new JSONObject();
        if(uno != null && !"".equals(uno)) {
            jsonObject.put("code", 200);
            jsonObject.put("msg", "success");
            List<Dynamic> dynamics = dynamicService.selectDynamicsByUno(uno);
            jsonObject.put("count", dynamics.size());
            jsonObject.put("data", dynamics);
        } else {
            jsonObject.put("code", 500);
        }
        dynamicService.updateDynamicReaded(uno);
        return jsonObject.toString();
    }

}
