# Cury Company - Análise de Dados SQL
Bem-vindo ao repositório de análise de dados da Cury Company! Este projeto foi desenvolvido para demonstrar habilidades avançadas em SQL e PLSQL, aplicadas a um cenário de negócio fictício. 
Abaixo, você encontrará uma visão geral do projeto, incluindo o problema de negócio, as premissas, a estratégia adotada, o produto final e a conclusão.

### Problema de Negócio
A Cury Company, está buscando otimizar o gerenciamento e análise de dados relacionados aos seus colaboradores, projetos e planos de saúde. A empresa enfrenta desafios relacionados à:
1. Gestão de Dependentes: Filtragem e análise dos dados dos dependentes dos colaboradores.
2. Avaliação de Salários e Senioridade: Identificação do colaborador com o maior salário e categorização de senioridade.
3. Atribuição de Projetos: Monitoramento da quantidade de colaboradores por projeto e departamento.
4. Plano de Saúde: Cálculo dos custos relacionados aos planos de saúde, considerando dependentes e senioridade.

### Premissas do Negócio
Para desenvolver a solução, foram feitas as seguintes premissas:
1. Estrutura de Dados: A empresa utiliza tabelas padrão para colaboradores, dependentes, projetos e planos de saúde.
2. Dados Temporais: Os cálculos de idade e valores financeiros são baseados na data atual e nos dados históricos disponíveis.
3. Validação de Dados: As inserções e cálculos precisam considerar a validade dos dados, como a existência de registros e a consistência dos valores inseridos.

### Estratégia da Solução
Para resolver os desafios descritos, foram implementadas as seguintes estratégias:
1. Filtragem e Análise: Utilização de SQL para filtrar e analisar dados dos dependentes com base em critérios específicos (nome e data de nascimento).
2. Cálculo de Salário e Senioridade: Consultas para identificar colaboradores com o maior salário e categorizar a senioridade com base em faixas salariais.
3. Atribuição e Relatórios: Geração de relatórios detalhados sobre a quantidade de colaboradores por projeto e departamento, e cálculo do valor total dos planos de saúde.
4. Procedimentos e Funções: Criação de procedimentos e funções PL/SQL para inserção de projetos, cálculo de idade e finalização de projetos, incluindo validações e inserção condicional.

### Produto Final do Projeto
O projeto inclui:
1. Consultas SQL: Diversas consultas para filtrar e analisar dados dos colaboradores e dependentes.
2. Procedimentos e Funções PL/SQL: Implementação de procedimentos e funções para gerenciar projetos e calcular dados relevantes.
3. Paginação de Dados: Técnicas para paginar a listagem de colaboradores.
4. Relatórios: Relatórios detalhados sobre o plano de saúde, senioridade dos colaboradores e atribuições de projetos.

### Conclusão
* Este projeto demonstra a aplicação de habilidades avançadas em SQL e PL/SQL para resolver problemas de negócios hipotéticos de maneira eficaz. Através da criação de consultas complexas, procedimentos e funções, 
foi possível abordar desafios comuns enfrentados por empresas no gerenciamento de dados de colaboradores e projetos.
* A Cury Company agora possui uma base sólida para análise e gestão de dados, proporcionando insights valiosos e facilitando a tomada de decisões estratégicas.
O código e as abordagens apresentadas neste projeto podem ser facilmente adaptados e expandidos para atender a requisitos de negócios reais e futuros.


### Observações
* A pasta **dados** é onde está localizado a criação do schema e a carga de dados.
* Os scripts e procedimentos SQL são projetados para serem executados em um ambiente Oracle Database e fornecem uma visão completa da gestão e análise de dados da Cury Company.

### Ferramentas Utilizadas
* SQL
* PLSQL
* Oracle
