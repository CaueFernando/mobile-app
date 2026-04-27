# 🐕 SteptoStop

Uma aplicação mobile para ajudar você a parar de fumar, com um pet que evolui conforme você progride em sua jornada!

## 📋 Sobre o Projeto

**SteptoStop** é um aplicativo interativo que gamifica o processo de cessação do tabagismo. Você cria um pet virtual que cresce e evolui conforme você alcança marcos sem fumar. O app rastreia seu progresso, economias de dinheiro e fornece suporte motivacional.

## ✨ Funcionalidades

- ✅ Dashboard com acompanhamento de progresso
- ✅ Navegação inferior com 5 abas principais
- ✅ Evolução do pet conforme você progride
- ✅ Contagem de dias sem nicotina
- ✅ Cálculo de dinheiro economizado
- ✅ Registro de vontades e emergências
- ✅ Sistema de VCoins (moeda in-app)
- ✅ Design responsivo e intuitivo

## 🚀 Como Começar

### Pré-requisitos

Certifique-se de ter instalado em sua máquina:
- **Node.js** (v18+) - [Download](https://nodejs.org/)
- **npm** (vem com Node.js)

### 1️⃣ Clonar o Repositório

```bash
git clone https://github.com/CaueFernando/mobile-app.git
cd mobile-app
```

### 2️⃣ Instalar Dependências

```bash
npm install
```

### 3️⃣ Iniciar o Servidor de Desenvolvimento

```bash
npm start
```

O servidor iniciará automaticamente em **http://localhost:4200/**

Abra seu navegador e acesse a URL. A aplicação recarregará automaticamente quando você fizer mudanças no código!

### 4️⃣ Build para Produção

```bash
npm run build
```

Os arquivos otimizados serão gerados na pasta `dist/`

## 📁 Estrutura do Projeto

```
src/
├── app/
│   ├── components/
│   │   ├── dashboard/           # Página principal
│   │   ├── bottom-nav/          # Navegação inferior
│   │   ├── statistics/          # Estatísticas
│   │   ├── shop/                # Loja de itens
│   │   ├── history/             # Histórico
│   │   └── profile/             # Perfil do usuário
│   ├── models/
│   │   └── pet.model.ts         # Modelo do Pet
│   ├── app.ts                   # Componente raiz
│   ├── app.routes.ts            # Configuração de rotas
│   └── app.html                 # Template principal
└── assets/                      # Imagens e recursos estáticos
```

## 🛠️ Comandos Disponíveis

| Comando | Descrição |
|---------|-----------|
| `npm start` | Inicia servidor de desenvolvimento |
| `npm run build` | Build para produção |
| `npm test` | Executa testes unitários |

## 🎮 Como Usar a Aplicação

1. **Dashboard** - Acompanhe seu progresso e evolução do pet
2. **+1 Puff** - Registre quando usar nicotina
3. **+1 Cigarro** - Registre quando fumar
4. **Tive vontade** - Registre crises de vontade
5. **Emergência** - Acesse recursos de ajuda
6. **Compartilhar Progresso** - Divida sua conquista em redes sociais

## 🔧 Tecnologias Utilizadas

- **Angular 21** - Framework web moderno
- **TypeScript** - Linguagem de programação tipada
- **SCSS** - Pré-processador CSS com variáveis
- **RxJS** - Programação reativa
- **Angular Router** - Roteamento entre páginas
- **Signals** - Reatividade moderna do Angular

## 📱 Responsividade

A aplicação foi projetada para funcionar perfeitamente em:
- Desktop (navegadores modernos)
- Tablet
- Mobile (iPhone, Android)

## 🤝 Como Contribuir

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📝 Licença

Este projeto está sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.

## 👨‍💻 Autor

Criado por **Cauê Fernando** - [GitHub](https://github.com/CaueFernando)

## 💬 Dúvidas ou Sugestões?

Se tiver alguma dúvida ou sugestão, abra uma **Issue** no repositório!

---

**⭐ Se gostou do projeto, deixa uma estrela no GitHub!**

```bash
ng e2e
```

Angular CLI does not come with an end-to-end testing framework by default. You can choose one that suits your needs.

## Additional Resources

For more information on using the Angular CLI, including detailed command references, visit the [Angular CLI Overview and Command Reference](https://angular.dev/tools/cli) page.
