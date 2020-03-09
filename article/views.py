from django.http import HttpResponse, Http404
from django.shortcuts import render


# Create your views here.

def hello(request):
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
