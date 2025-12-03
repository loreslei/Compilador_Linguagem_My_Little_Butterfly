import java.io.*;
import java_cup.runtime.Symbol;

public class Main {

    public static void main(String[] args) {
        /* MODO 1: LEITURA DE ARQUIVO 
           (Ativado quando você roda: java Main input_teste.fly)
           Este modo lê o arquivo inteiro, permitindo comandos em várias linhas.
        */
        if (args.length > 0) {
            try {
                String nomeArquivo = args[0];
                
                System.out.println("=== Lendo arquivo: " + nomeArquivo + " ===");
                
                // FileInput + InputStreamReader garante que leremos UTF-8 (emojis) corretamente
                FileInputStream fis = new FileInputStream(nomeArquivo);
                InputStreamReader isr = new InputStreamReader(fis, "UTF-8");
                
                scanner scanner = new scanner(isr);
                parser parser = new parser(scanner);
                
                // O parser retorna o nó raiz (que definimos como Runnable no .cup)
                Symbol result = parser.parse();
                
                // Executa o código lido
                if (result != null && result.value instanceof Runnable) {
                    ((Runnable) result.value).run();
                } else {
                    System.out.println("O arquivo foi lido, mas não gerou ações executáveis.");
                }
                
                System.out.println("\n=== Execução Finalizada ===");
                
            } catch (Exception e) {
                System.err.println("Erro fatal ao ler arquivo: " + e.getMessage());
                e.printStackTrace();
            }
        } 
        /* MODO 2: INTERATIVO 
           (Ativado quando você roda apenas: java Main)
           Atenção: Este modo lê LINHA POR LINHA. Comandos multi-linha vão falhar aqui.
        */
        else {
            modoInterativo();
        }
    }

    public static void modoInterativo() {
        System.out.println("=== Linguagem Fly (Modo Interativo) ===");
        System.out.println("Dica: Comandos multi-linha (como if/for) não funcionam bem aqui.");
        System.out.println("      Use um arquivo .fly para códigos complexos.");
        System.out.println("Digite 'exit' para sair.");

        try {
            BufferedReader reader = new BufferedReader(new InputStreamReader(System.in, "UTF-8"));
            
            // Loop infinito de leitura
            while (true) {
                System.out.print("\n> ");
                String input = reader.readLine();

                if (input == null || input.trim().equalsIgnoreCase("exit")) {
                    break;
                }
                if (input.trim().isEmpty()) continue;

                try {
                    // Cria um novo scanner para cada linha digitada
                    scanner scanner = new scanner(new StringReader(input));
                    parser parser = new parser(scanner);
                    
                    Symbol result = parser.parse();
                    if (result != null && result.value instanceof Runnable) {
                        ((Runnable) result.value).run();
                    }
                } catch (Exception e) {
                    System.out.println("Erro: " + e.getMessage());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}