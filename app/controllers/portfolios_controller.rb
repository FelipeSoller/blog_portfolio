class PortfoliosController < ApplicationController
  def index
    @portfolio_items = Portfolio.all
  end

  def ruby_on_rails # Este método de ação é responsável pela view ruby_on_rails.html.rb
    # @ruby_on_rails_portfolio_items -> Variável de instância que irá receber somente os itens com 'Ruby on Rails' no subtitle
    # Portfolio.ruby_on_rails_portfolio_items -> Objeto Portfolio utilizando scope criado no portfolio.rb (model)
    @ruby_on_rails_portfolio_items = Portfolio.ruby_on_rails_portfolio_items
  end

  def angular # Este método de ação é responsável pela view angular.html.rb
    # @angular_portfolio_items -> Variável de instância que irá receber somente os itens com 'Angular' no subtitle
    # Portfolio.angular_portfolio_items -> Objeto Portfolio utilizando scope criado no portfolio.rb (model)
    @angular_portfolio_items = Portfolio.angular_portfolio_items
  end

  def new
    @portfolio_item = Portfolio.new
    3.times {
      # método build irá adicionar a variável de instância @portfolio_item a construção do formulário de tecnologias aninhado para o formulário portfolio_item. Ou seja, o formulário de tecnologias estará construído dentro do formulário de portfolios.
      @portfolio_item.technologies.build
    }
  end

  def show
    @portfolio_item = Portfolio.find(params[:id])
  end

  def create
    @portfolio_item = Portfolio.new(params.require(:portfolio).permit(:title, :subtitle, :body, technologies_attributes: [:name]))
    # technologies_attributes: [:name] -> está dizendo ao Rails que será permitido aceitar atributos do formulário de tecnologias que tenham o nome :name

    respond_to do |format|
      if @portfolio_item.save
        format.html { redirect_to portfolios_path, notice: "Portfolio item was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @portfolio_item = Portfolio.find(params[:id])
  end

  def update
    @portfolio_item = Portfolio.find(params[:id])

    respond_to do |format|
      if @portfolio_item.update(params.require(:portfolio).permit(:title, :subtitle, :body))
        format.html { redirect_to portfolios_path, notice: "Portfolio item was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @portfolio_item = Portfolio.find(params[:id])

    @portfolio_item.destroy
    respond_to do |format|
      format.html { redirect_to portfolios_path, notice: "Portfolio item was successfully deleted." }
    end
  end
end
