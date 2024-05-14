﻿using Microsoft.EntityFrameworkCore;

namespace SigmaMarketing.Model.Models.PagedList
{
    public class PagedList<T>
    {
        private PagedList(List<T> items, int page, int pageSize, int totalCount)
        {
            Items = items;
            Page = page;
            PageSize = pageSize;
            TotalCount = totalCount;
        }

        public List<T> Items { get; set; }
        public int Page { get; set; }
        public int PageSize { get; set; }
        public int TotalCount { get; set; }
        public bool HasNextPage => Page * PageSize < TotalCount;
        public bool HasPreviousPage => Page > 1;

        public static async Task<PagedList<T>> CreateAsync(IQueryable<T> query, int page, int pageSize)
        {
            var totalCount = await query.CountAsync();
            var items = await query.Skip((page - 1) * pageSize).Take(pageSize).ToListAsync();
            return new PagedList<T>(items, page, pageSize, totalCount);
        }


        public static PagedList<T> CreateEmpty(int page, int pageSize)
        {
            return new PagedList<T>(new List<T>(), page, pageSize, 0);
        }
    }
}
