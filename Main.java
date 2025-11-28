import java.io.*;
import java_cup.runtime.Symbol;

public class Main {

    public static void main(String[] args) {
        try {
            BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
            // Criamos o scanner sem input inicial
            scanner scanner = new scanner(new StringReader(""));
            parser parser = new parser(scanner);

            System.out.println("=== Linguagem Iniciada ===");
            System.out.println("Digite 'exit' para sair.");

            while (true) {
                System.out.print("\n> ");
                String input = reader.readLine();

                if (input == null || input.equalsIgnoreCase("exit")) {
                    break;
                }

                if (input.trim().isEmpty()) continue;

                try {
                    // Reinicia o scanner com a nova linha
                    scanner.yyreset(new StringReader(input));

                    // O parser vai montar a árvore de execução
                    Symbol result = parser.parse();

                    // O valor retornado é um Runnable (a nossa stmt_list)
                    Runnable programa = (Runnable) result.value;

                    // AGORA executamos o código
                    if (programa != null) {
                        programa.run();
                    }

                } catch (Exception e) {
                    System.out.println("Erro de sintaxe ou execução: " + e.getMessage());
                    // e.printStackTrace(); // Descomente para debugar
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}