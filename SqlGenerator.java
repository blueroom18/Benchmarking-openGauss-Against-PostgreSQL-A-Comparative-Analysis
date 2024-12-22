package DBProject3;

/**
 * @author blueroom
 * @studentID 12310814
 * @school Sustech
 */
import java.util.Random;

public class SqlGenerator {
    private long m;  // 表格的总行数
    private long n;  // 表格的列数
    private String[] columnNames;  // 列字段名
    private String[] columnTypes;  // 列数据类型
    private Random random;

    public SqlGenerator(long m, long n, String[] columnNames, String[] columnTypes) {
        this.m = m;
        this.n = n;
        this.columnNames = columnNames;
        this.columnTypes = columnTypes;
        this.random = new Random();
    }

    // 根据输入生成CREATE TABLE语句
    public String generateCreateTableSql(String tableName) {
        StringBuilder sql = new StringBuilder();
        sql.append("CREATE TABLE ").append(tableName).append(" (");

        for (int i = 0; i < n; i++) {
            sql.append(columnNames[i]).append(" ").append(columnTypes[i]);
            if (i < n - 1) {
                sql.append(", ");
            }
        }

        sql.append(");");
        return sql.toString();
    }

    // 根据输入生成批量INSERT语句，数据为随机数或随机字符串
    public String generateBatchInsertSql(String tableName, int batchSize) {
        StringBuilder sql = new StringBuilder();
        sql.append("INSERT INTO ").append(tableName).append(" (");

        // 构建字段部分
        for (int j = 0; j < n; j++) {
            sql.append(columnNames[j]);
            if (j < n - 1) {
                sql.append(", ");
            }
        }

        sql.append(") VALUES ");

        // 生成批量插入数据
        for (long i = 0; i < m; i++) {
            sql.append("(");

            // 根据数据类型生成随机数据
            for (int j = 0; j < n; j++) {
                sql.append(generateRandomData(columnTypes[j]));
                if (j < n - 1) {
                    sql.append(", ");
                }
            }

            sql.append(")");

            // 每生成完一个批次的INSERT数据，检查是否需要换行或分隔
            if ((i + 1) % batchSize == 0 || i == m - 1) {
                sql.append(";");
                if (i < m - 1) {
                    sql.append("\n");
                    sql.append("INSERT INTO ").append(tableName).append(" (");
                    for (int j = 0; j < n; j++) {
                        sql.append(columnNames[j]);
                        if (j < n - 1) {
                            sql.append(", ");
                        }
                    }
                    sql.append(") VALUES ");
                }
            } else {
                sql.append(", ");
            }
        }

        return sql.toString();
    }

    // 根据数据类型生成随机数据
    private String generateRandomData(String dataType) {
        switch (dataType.toLowerCase()) {
            case "int":
                return String.valueOf(random.nextInt(1000));  // 生成0-999之间的整数
            case "long":
                return String.valueOf(random.nextLong());  // 生成一个随机long值
            case "varchar":
                return "'" + generateRandomString(10) + "'";  // 生成10个字符的随机字符串
            default:
                return "NULL";  // 默认返回NULL（可以根据需求扩展）
        }
    }

    // 生成随机字符串
    private String generateRandomString(int length) {
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder randomString = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            randomString.append(characters.charAt(random.nextInt(characters.length())));
        }
        return randomString.toString();
    }

    public static void main(String[] args) {
        // 示例输入
        long m = 50000;  // 总行数
        long n = 2;  // 列数
        String[] columnNames = {"id", "name", "age"};
        String[] columnTypes = {"int", "varchar", "long"};

        // 创建SqlGenerator对象
        SqlGenerator generator = new SqlGenerator(m, n, columnNames, columnTypes);

        // 生成CREATE TABLE语句
        String createSql = generator.generateCreateTableSql("person");
        System.out.println(createSql);
        System.out.println();

        // 生成批量INSERT语句，设置每次插入批次为100条
        String insertSql = generator.generateBatchInsertSql("person", 100000);
        System.out.println(insertSql);
    }
}
