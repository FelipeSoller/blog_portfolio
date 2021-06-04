class Portfolio < ApplicationRecord
  has_many :technologies

  # Define que o model do portfolio irá receber atributos de outro formulário. Nesse caso, do formulário de tecnologias.
  accepts_nested_attributes_for :technologies,
                                reject_if: lambda { |attrs| attrs['name'].blank? }

  include Placeholder # chama módulo placeholder concern criado para gerar imagens.
  validates_presence_of :title, :body, :main_image, :thumb_image

  # cria um scope que é chamado no controller de portfolios filtrando somente os itens com 'Ruby on Rails' no subtitle
  scope :ruby_on_rails_portfolio_items, -> { where(subtitle: 'Ruby on Rails') }

  # cria um scope que é chamado no controller de portfolios filtrando somente os itens com 'Angular' no subtitle
  scope :angular_portfolio_items, -> { where(subtitle: 'Angular') }

  # after_initialize -> É chamado sempre antes do método de ação new.
  # set_defaults -> É o método que irá atribuir valores padrão aos atributos chamados.
  after_initialize :set_defaults

  def set_defaults
    # ||= -> Para este caso, significa que se ao criarmos um portfolio item e não adicionarmos as respectivas imagens, serão atribudos valores específicos. Caso contrário, os valores atribuídos serão os indicados no formulário.
    # Placeholder.image_generator(height: 600, width: 400) -> Chama método criado para gerar imagens
    self.main_image ||= Placeholder.image_generator(height: 600, width: 400)
    self.thumb_image ||= Placeholder.image_generator(height: 350, width: 200)
  end
end