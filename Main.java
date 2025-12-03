import java.io.*;
import java_cup.runtime.Symbol;

public class Main {

    public static void main(String[] args) {
        // MODO 1: Leitura de Arquivo .fly
        if (args.length > 0) {
            try {
                String nomeArquivo = args[0];
                if (!nomeArquivo.endsWith(".fly")) {
                    System.out.println("Aviso: O arquivo não possui extensão .fly");
                }
                
                System.out.println("Lendo arquivo: " + nomeArquivo);
                // Cria o scanner lendo direto do arquivo
                scanner scanner = new scanner(new FileReader(nomeArquivo));
                parser parser = new parser(scanner);
                
                Symbol result = parser.parse();
                Runnable programa = (Runnable) result.value;
                
                if (programa != null) {
                    programa.run();
                }
                
            } catch (Exception e) {
                System.err.println("Erro ao ler arquivo: " + e.getMessage());
                e.printStackTrace();
            }
        } 
        // MODO 2: Interativo (Se não passar argumentos)
        else {
            modoInterativo();
        }
    }

    public static void modoInterativo() {
        try {
            BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
            scanner scanner = new scanner(new StringReader(""));
            parser parser = new parser(scanner);

            System.out.println("=== Linguagem Fly (Modo Interativo) ===");
            System.out.println("Digite 'exit' para sair.");

            while (true) {
                System.out.print("\n> ");
                String input = reader.readLine();

                if (input == null || input.equalsIgnoreCase("exit")) {
                    break;
                }
                if (input.trim().isEmpty()) continue;

                try {
                    scanner.yyreset(new StringReader(input));
                    Symbol result = parser.parse();
                    Runnable programa = (Runnable) result.value;
                    if (programa != null) programa.run();
                } catch (Exception e) {
                    System.out.println("Erro: " + e.getMessage());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}