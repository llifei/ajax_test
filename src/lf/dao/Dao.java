package lf.dao;

import cn.itcast.jdbc.TxQueryRunner;
import lf.domain.City;
import lf.domain.Province;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import java.sql.SQLException;
import java.util.List;

public class Dao {
    private QueryRunner qr=new TxQueryRunner();
    /**
     * 查询所有的省
     * @return
     */
    public List<Province> findAllProvince(){
        String sql="SELECT * FROM t_province";
        try {
            return qr.query(sql,new BeanListHandler<Province>(Province.class));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * 查询指定省下的所有市
     * @param pid
     * @return
     */
    public List<City>findByProvince(int pid){
        String sql="SELECT * FROM t_city WHERE pid=?";
        try {
            return qr.query(sql,new BeanListHandler<City>(City.class),pid);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
