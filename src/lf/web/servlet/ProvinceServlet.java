package lf.web.servlet;

import lf.dao.Dao;
import lf.domain.Province;
import net.sf.json.JSONArray;
import org.dom4j.Attribute;
import org.dom4j.Document;
import org.dom4j.io.SAXReader;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

@WebServlet("/ProvinceServlet")
public class ProvinceServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");

        /**
         * 1.通过dao得到所有的省
         * 2.把List<Province>转换成json
         * 3.发送给客户端
         */
        Dao dao=new Dao();
        List<Province> provinceList=dao.findAllProvince();
        String json= JSONArray.fromObject(provinceList).toString();

        resp.getWriter().print(json);

    }
}
