package lf.web.servlet;

import lf.dao.Dao;
import lf.domain.City;
import net.sf.json.JSONArray;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

@WebServlet("/CityServlet")
public class CityServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/xml;charset=utf-8");

        /**
         * 1.获取名为proName的参数
         * 2.使用这个省名称查询数据库，得到List<City>
         * 3.转发成json，转发给客户端
         */
        int pid=Integer.parseInt(req.getParameter("pid"));
        Dao dao=new Dao();
        List<City> cityList=dao.findByProvince(pid);

        String json= JSONArray.fromObject(cityList).toString();
        resp.getWriter().print(json);

    }
}
