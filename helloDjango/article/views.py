from django.core.paginator import Paginator
from django.http import HttpResponse, Http404
from django.shortcuts import render


# Create your views here.

def hello(request):
    1/0
    return HttpResponse("hello world")


def hello_num(request, num):
    try:
        num = int(num)
        return HttpResponse(f"hello world {num}")
    except:
        return Http404()


def template(request):
    context = {'name': 'tim',
               'itemList': ['item1', 'item2', 'item3']
               }
    return render(request, '1.html', context=context)


def template2(request):
    return render(request, '2.html')


def template3(request):
    return render(request, '3.html')


def staticTest(request):
    return render(request, 'staticTest.html')


def error_404(request, exception):
    return render(request, 'error_404.html')


def error_500(request):
    return render(request, 'error_500.html')


def listing(request):
    contact_list = list(range(100))
    paginator = Paginator(contact_list, 2)  # Show 25 contacts per page.
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)
    return render(request, 'list.html', context={'page_obj': page_obj})
