# 🎂 Jogo Cake Clicker - Projeto

Este projeto é um jogo idle baseado no famoso **Cookie Clicker**, onde os jogadores clicam em um objeto principal para acumular pontos e podem comprar melhorias para automatizar a geração de pontos.

## 👨‍🏫 Professor Responsável 

+ Carlos Eduardo Duque Polito

## 📌 Objetivo do Jogo
O jogador precisa clicar repetidamente no bolo para ganhar dinheiro. Conforme acumula dinheiro, pode comprar upgrades que aumentam a produção automaticamente.

## 👥 Público-alvo
Cake Clicker é para todos que adoram jogos idle e de cliques, desde quem joga casualmente para se divertir até os que adoram levar o jogo a sério e desbloquear melhorias sem parar. 

## ✖️ O que não teremos no projeto
+ Comércio ou qualquer tipo de item virtual.
+ Implementação de microtransações ou compras com dinheiro real.

## 🎮 Mecânicas do Jogo
- **Clique Principal:** O jogador pode clicar para ganhar pontos manualmente.
- **Upgrades:** Melhorias que aumentam a produção passiva de pontos.
- **Sistema Idle:** Os pontos continuam sendo gerados mesmo quando o jogador não está clicando.
<!-- - **Loja de Melhorias:** Permite comprar upgrades para aumentar a produção. -->
- **Progresso Salvo:** O jogo salva automaticamente o progresso do jogador.


## 📋Matriz de Requisitos

![Matriz de Requisitos](https://i.imgur.com/PtClEIt.png)


## 🗃️ Dicionário de Dados

### **Entidade Jogador**
Essa entidade armazena os dados do jogador.

- **`id_jogador`**: INT - Identificador único do jogador.
- **`pontuacao`**: INT - Quantidade total de pontos acumulados.
<!-- - **`upgrades_comprados`**: JSON - Lista de melhorias adquiridas. -->

<!-- ### **Entidade Upgrades**
Essa entidade define os upgrades disponíveis no jogo.

- **`id_upgrade`**: INT - Identificador único do upgrade.
- **`nome_upgrade`**: VARCHAR(45) - Nome do upgrade.
- **`custo`**: INT - Custo em pontos para comprar o upgrade.
- **`multiplicador`**: FLOAT - Multiplicador que aumenta a produção de pontos. -->

<!-- ### **Entidade Progresso**
Essa entidade armazena o progresso do jogador.

- **`id_progresso`**: INT - Identificador único do progresso salvo.
- **`id_jogador`**: INT - Relacionamento com a entidade `Jogador`.
- **`data_ultimo_login`**: DATE - Data do último login do jogador. -->

## 🚀 Tecnologias Utilizadas
- **Linguagem:** Dart
- **Engine:** Flutter
- **Banco de Dados:** Hive


## Diagramas UML

- Diagrama de Caso de Uso
![Diagrama de Caso de Uso](https://i.imgur.com/5qmpe3Y.jpeg)

- Fluxograma

![Fluxograma](https://i.imgur.com/dUHqss0.jpeg)

- Diagrama de Componentes
![Diagrama de Componentes](https://i.imgur.com/NbTVrmY.png)

- Diagramas de Sequência
![Diagrama de Componentes](https://i.imgur.com/RMVZrtJ.png)


## 📔 Plano de Capacidade
### Armazenamento de Dados
  Dados a serem armazenados por usuário:
- id_jogador
- Cookies acumulados
- Upgrades comprados

### Estimativa de espaço:
- Cada usuário ocupa ~0.5 KB.
- Para 50 usuários: ~25 KB.
- Total estimado: Menos de 50 KB.

### Processamento
Carga estimada:
- Operações por segundo: < 1.

### Autenticação (Firebase Auth)
- Até 10.000 autenticações/mês no plano gratuito.

### Custos
Plano Gratuito (Spark):
- Firestore: 1 GB de armazenamento.
- Cloud Functions: 2 milhões de invocações/mês.
- Largura de banda: 10 GB/mês.
- Custo total estimado: R$ 0.

## 🛡️ Estratégia de Backup e Recuperação

O jogo Cake Clicker salva os dados do jogador localmente usando o banco de dados Hive. Isso garante que o progresso não seja perdido mesmo que o jogador feche o app.

### Backup

- Os dados são salvos automaticamente a cada 5 segundos e também quando o jogador fecha o aplicativo.
- As informações salvas incluem a pontuação e os upgrades comprados.
- O arquivo de backup fica no próprio celular ou computador do jogador.

### Recuperação
- Quando o jogador abre o jogo, o sistema carrega os dados salvos automaticamente.
- Se os dados não forem encontrados ou estiverem corrompidos, o jogo começa do zero com os valores iniciais.

### Responsável
- O próprio sistema do jogo faz todo o processo de salvar e recuperar os dados.
- O desenvolvedor é responsável por programar essas funções corretamente.


## 📘 Estudo de caso

O Cake Clicker é um jogo idle/clicker em que o jogador clica em um bolo para acumular pontos e pode usar esses pontos para comprar upgrades que aumentam a geração automática de pontos. O jogo funciona offline e salva o progresso localmente com o banco de dados Hive.

O principal ator do sistema é o jogador, responsável por interagir com a interface do jogo, realizar cliques e adquirir upgrades. As funcionalidades do sistema incluem clique manual para gerar pontos, compra de upgrades, geração automática baseada nos upgrades adquiridos, além do salvamento e carregamento automático do progresso.

As entidades principais são o Jogador, que possui um ID, pontuação e lista de upgrades, e os Upgrades, que têm nome, custo, produção por segundo e quantidade comprada. O custo dos upgrades aumenta progressivamente, e a geração passiva é determinada pela soma da produção de todos os upgrades ativos.

O fluxo principal começa com o carregamento do progresso salvo, seguido pelo ciclo de clicar, ganhar pontos, comprar upgrades, gerar pontos automaticamente e salvar os dados periodicamente. Caso o jogador tente comprar sem pontos suficientes, o sistema exibe uma mensagem de erro.

<!-- Esse estudo de caso serve como base para a criação de diagramas UML, como casos de uso, classes, sequência e atividades. -->

## 👨‍💻 Desenvolvedores

### Eric Daiske Nogata, Carla Abreu, Luiz Henrique Pereira


<!-- ## 5️⃣ Documentação de Tabelas e Colunas
- Os tipos de dados foram definidos para garantir consistência e eficiência.
- A normalização foi aplicada para evitar redundâncias.
- Chaves primárias e estrangeiras asseguram integridade referencial.

## 6️⃣ Modelos Conceitual, Lógico e Físico
- **Modelo Conceitual:** Define as entidades e relacionamentos de maneira abstrata.
- **Modelo Lógico:** Estrutura os dados usando tabelas, atributos e relacionamentos.
- **Modelo Físico:** Implementação final no banco de dados, incluindo índices e constraints.

## 7️⃣ Plano de Projeto Inicial
| Etapa | Descrição |
|------|------------|
| Definição do Banco de Dados | Criar estrutura inicial (MER, Modelos) |
| Implementação | Desenvolver o banco com SQL |
| Testes | Validar estrutura e consistência dos dados |
| Deploy | Subir banco para ambiente de produção |
| Manutenção | Monitorar e otimizar desempenho | -->


<!-- ## 🛠️ Como Rodar o Jogo
1. Clone o repositório:
   ```sh
   git clone https://github.com/seu-usuario/seu-repositorio.git -->
