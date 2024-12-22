package DBProject3;

/**
 * @author blueroom
 * @studentID 12310814
 * @school Sustech
 */
import java.util.Scanner;

public class SqlSetGenerator{

    // 生成一个事务的SQL操作，包含插入、更新和删除操作
    public static String generateTransactionSql(int transactionId) {
        StringBuilder sql = new StringBuilder();
        sql.append("BEGIN;\n");

        // 插入新数据
        sql.append("INSERT INTO person2 (id, name) VALUES (")
                .append(transactionId)
                .append(", 'Name")
                .append(transactionId)
                .append("');\n");

        // 更新数据
        sql.append("UPDATE person2 SET name = 'Name Updated ")
                .append(transactionId)
                .append("' WHERE id = ")
                .append(transactionId)
                .append(";\n");

        // 删除数据
        sql.append("DELETE FROM person2 WHERE id = ")
                .append(transactionId)
                .append(";\n");

        // 提交事务
        sql.append("COMMIT;\n");

        return sql.toString();
    }

    // 生成指定次数的事务SQL操作
    public static String generateMultipleTransactions(int times) {
        StringBuilder allSql = new StringBuilder();

        // 循环生成每个事务
        for (int i = 1; i <= times; i++) {
            allSql.append(generateTransactionSql(i)).append("\n");
        }

        return allSql.toString();
    }

    public static void main(String[] args) {
        // 创建Scanner对象以接收用户输入
        Scanner scanner = new Scanner(System.in);

        // 提示用户输入事务数量
        System.out.print("请输入事务次数：");
        int times = scanner.nextInt();

        // 生成并输出SQL指令集合
        String transactionsSql = generateMultipleTransactions(times);
        System.out.println("生成的SQL指令集合：\n");
        System.out.println(transactionsSql);

        scanner.close();
    }
}

