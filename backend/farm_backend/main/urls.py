from django.urls import path
from . import views
from . import auth_views

urlpatterns = [
    path('login/', views.login, name='login'),
    path('signup/', auth_views.signup, name='signup'),
    path('submit-data/', views.submit_data, name='submit_data'),
    path('get-config/', views.get_config, name='get_config'),
    path('sync-data/', views.sync_data, name='sync_data'),
]