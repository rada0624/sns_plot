Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'index#index'
  get   'mypage'        => 'mypage#home'
  post  'mypage/create' => 'mypage#create'
  patch 'mypage/update' => 'mypage#update'
  post  'mypage/redraw_carender' => 'mypage#redraw_carender'
  post  'mypage/redraw_history' => 'mypage#redraw_history'
  post  'mypage/get_edit_history_data' => 'mypage#get_edit_history_data'
  get   'users/field' => 'field#home'
  post  'users/field/update' => 'field#update' # 自動推測のため不要？

  get   '/detail/:id'       , to: 'detail#home'
  get   '/detail/:id/edit'  , to: 'detail#edit'
  patch '/detail/update', to: 'detail#create'

  get   '/member/:id', to: 'member#home'


end
