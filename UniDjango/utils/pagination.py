from rest_framework.pagination import PageNumberPagination
from rest_framework.response import Response


class CustomPageNumberPagination(PageNumberPagination):
    """
    自定义分页类
    提供基本的分页信息，方便前端使用,举例：
    - GET /department/ - 默认分页
    - GET /department/?page=2 - 指定页码
    - GET /department/?page_size=5 - 自定义每页大小
    - GET /department/?page=2&page_size=15 - 组合参数
    """
    page_size = 10  # 默认每页显示条数
    page_size_query_param = 'page_size'  # 每页大小的查询参数名
    max_page_size = 100  # 最大每页显示条数

    def get_paginated_response(self, data):
        """
        返回自定义格式的分页响应
        """
        return Response({
            'count': self.page.paginator.count,  # 总记录数
            'total_pages': self.page.paginator.num_pages,  # 总页数
            'current_page': self.page.number,  # 当前页码
            'page_size': self.get_page_size(self.request),  # 每页大小
            'next': self.get_next_link(),  # 下一页链接
            'previous': self.get_previous_link(),  # 上一页链接
            'results': data  # 数据列表
        })