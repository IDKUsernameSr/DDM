# 🎂 Jogo Cake Clicker - Projeto

Este projeto é um jogo idle baseado no famoso **Cookie Clicker**, onde os jogadores clicam em um objeto principal para acumular pontos e podem comprar melhorias para automatizar a geração de pontos.

---

# Professor Responsável 
Carlos Eduardo Duque Polito

---

## 📌 Objetivo do Jogo
O jogador precisa clicar repetidamente no bolo para ganhar dinheiro. Conforme acumula dinheiro, pode comprar upgrades que aumentam a produção automaticamente.

---

## 🎮 Mecânicas do Jogo
- **Clique Principal:** O jogador pode clicar para ganhar pontos manualmente.
- **Upgrades:** Melhorias que aumentam a produção passiva de pontos.
- **Sistema Idle:** Os pontos continuam sendo gerados mesmo quando o jogador não está clicando.
<!-- - **Loja de Melhorias:** Permite comprar upgrades para aumentar a produção. -->
- **Progresso Salvo:** O jogo salva automaticamente o progresso do jogador.

---

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

---

## 🚀 Tecnologias Utilizadas
- **Linguagem:** Dart
- **Engine:** Flutter
- **Banco de Dados:** Hive

---

## Plano de Capacidade
### Armazenamento de Dados (Firestore ou Realtime Database)
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
- Até 10.000 autenticações/mês no plano gratuito (suficiente para um projeto escolar).

### Custos
Plano Gratuito (Spark):
- Firestore: 1 GB de armazenamento.
- Cloud Functions: 2 milhões de invocações/mês.
- Largura de banda: 10 GB/mês.
- Custo total estimado: R$ 0.

---

## Diagramas UML

- Diagrama de Componentes
![Diagrama de Componentes](https://i.imgur.com/NbTVrmY.png)


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
