package web;

import dao.iml.AdminDaoIml;
import dao.iml.DormitoryDaoIml;
import dao.iml.UserDaoIml;
import domain.Admin;
import domain.Dormitory;
import domain.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "SignServlet",urlPatterns = "/sign")
public class SignServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        PrintWriter printWriter = response.getWriter();
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String password_cofirmation = request.getParameter("password_confirmation");
        String name = request.getParameter("name");
        String dormitory_id = request.getParameter("dormitory");

        if (!password.equals(password_cofirmation)) {
            printWriter.println("<script>alert('两次密码输入不一致');location.href='/dormitory/sign';</script>");
            return;
        }
        //从两个表中查询是否有重名用户
        AdminDaoIml adminDaoIml = new AdminDaoIml();
        UserDaoIml userDaoIml  = new UserDaoIml();
        if (adminDaoIml.existAdmin(username) || userDaoIml.existUser(username)) {
            printWriter.println("<script>alert('该用户已存在');location.href='/dormitory/sign';</script>");
            return;
        }
        //如果注册成为管理员
        if (request.getParameter("admin").equals("1")) {
            Admin admin = new Admin();
            admin.setUsername(username);
            admin.setName(name);
            admin.setDormitory_id(Integer.parseInt(dormitory_id));
            admin.setPassword(password);
            admin.setStatus(0);
            adminDaoIml.add(admin);
            printWriter.println("<script>alert('注册成功，请等待管理员审核！');location.href='/dormitory/sign';</script>");
            return;
        }else {
            //注册成为用户
            String _class = request.getParameter("class");
            String nickname = request.getParameter("nickname");
            String room = request.getParameter("room");
            User user  = new User();
            user.setUsername(username);
            user.setPassword(password);
            user.setName(name);
            user.setNickname(nickname);
            user.set_class(_class);
            user.setDormitory_id(Integer.parseInt(dormitory_id));
            user.setRoom(Integer.parseInt(room));
            userDaoIml.add(user);
            printWriter.println("<script>alert('注册成功，请登录！');location.href='/dormitory/login';</script>");
            return;
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        DormitoryDaoIml dormitoryDaoIml = new DormitoryDaoIml();
        List<Dormitory> dormitories = dormitoryDaoIml.getAll();
        request.setAttribute("dormitories",dormitories);
        request.getRequestDispatcher("/login.jsp").forward(request,response);
    }

}
