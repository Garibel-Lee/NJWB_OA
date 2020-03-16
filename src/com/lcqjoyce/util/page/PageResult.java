package com.lcqjoyce.util.page;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;


public class PageResult {
    /**
     * 结果集对象
     */
    private List listData; // 结果集数据:通过sql查询
    private Integer totalCount; // 结果总数:通过sql查询

    private Integer currentPage; // 当前页:用户传入
    private Integer pageSize; // 每页显示条数:用户传入

    private Integer beginPage = 1; // 首页
    private Integer pervPage; // 上一页:计算出来
    private Integer nextPage; // 下一页:计算出来
    private Integer totalPage; // 总页数/末页:计算出来

    private Integer beginIndex;
    private Integer endIndex;

    private List<Integer> pageItems = Arrays.asList(3, 5, 10);

    /**
     * 如果总数据条数为0,返回一个空集
     *
     * @param pageSize
     * @return
     */
    public static PageResult empty(Integer pageSize) {
        return new PageResult(new ArrayList(), 0, 1, pageSize);
    }

    public PageResult(List listData, Integer totalCount, Integer currentPage, Integer pageSize) {
        this.listData = listData;
        this.totalCount = totalCount;
        this.currentPage = currentPage;
        this.pageSize = pageSize;

        this.totalPage = totalCount % pageSize == 0 ? totalCount / pageSize : totalCount / pageSize + 1;
        this.nextPage = currentPage + 1 <= totalPage ? currentPage + 1 : totalPage;
        this.pervPage = currentPage - 1 >= 1 ? currentPage - 1 : 1;
        // -----------------------------------------
        PageIndex pageIndex = PageIndex.getPageIndex(pageSize, currentPage, totalPage);
        this.beginIndex = pageIndex.getBeginIndex();
        this.endIndex = pageIndex.getEndIndex();
    }

    public List getListData() {
        return listData;
    }

    public void setListData(List listData) {
        this.listData = listData;
    }

    public Integer getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(Integer totalCount) {
        this.totalCount = totalCount;
    }

    public Integer getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(Integer currentPage) {
        this.currentPage = currentPage;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public Integer getBeginPage() {
        return beginPage;
    }

    public void setBeginPage(Integer beginPage) {
        this.beginPage = beginPage;
    }

    public Integer getPervPage() {
        return pervPage;
    }

    public void setPervPage(Integer pervPage) {
        this.pervPage = pervPage;
    }

    public Integer getNextPage() {
        return nextPage;
    }

    public void setNextPage(Integer nextPage) {
        this.nextPage = nextPage;
    }

    public Integer getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(Integer totalPage) {
        this.totalPage = totalPage;
    }

    public Integer getBeginIndex() {
        return beginIndex;
    }

    public void setBeginIndex(Integer beginIndex) {
        this.beginIndex = beginIndex;
    }

    public Integer getEndIndex() {
        return endIndex;
    }

    public void setEndIndex(Integer endIndex) {
        this.endIndex = endIndex;
    }

    public List<Integer> getPageItems() {
        return pageItems;
    }

    public void setPageItems(List<Integer> pageItems) {
        this.pageItems = pageItems;
    }

}
