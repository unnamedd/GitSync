import Foundation
@testable import Utils

extension CommitCountDB{
    /**
     * Returns total commit count for a month in a year in a repo
     */
    func monthCount(repoId:String,year:Int,month:Int) -> Int? {//rename to monthCount ⚠️️
        guard let dayDict:DayDict = repos[repoId]?[year]?[month] else {return nil}
        return dayDict.values.reduce(0) {
            return $0 + $1
        }
    }
    /**
     * Tot commitCount for repo
     */
    func repoCount(repoId:String) -> Int?{//rename to
        guard let yearDict:YearDict = repos[repoId] else {return nil}//find correct year
        let count:Int = yearDict.keys.reduce(0) {
            guard let yearCount = yearCount(repoId: repoId, year: $1) else {return $0}
            return $0 + yearCount
        }
        return count
    }
    /**
     * Tot commitCount for repo in year
     */
    func yearCount(repoId:String,year:Int) ->Int? {
        guard let yearDict:YearDict = repos[repoId] else {return nil}//find correct repo
        guard let monthDict:MonthDict = yearDict[year] else {return nil}//find correct year
        let count:Int = monthDict.keys.reduce(0) {
            guard let monthCount:Int = monthCount(repoId: repoId, year: year, month: $1) else {return $0}
            return $0 + monthCount
        }
        return count
    }
    /**
     * tot commit count for repo in year in month in day
     */
    func dayCount(repoId:String,date:DBDate) -> Int?{
        guard let yearDict:YearDict = repos[repoId] else {return nil}//find correct repo
        guard let monthDict:MonthDict = yearDict[date.year] else {return nil}//find correct year
        guard let dayDict:DayDict = monthDict[date.month] else {return nil}//find correct month
        guard let dayCount:Int = dayDict[date.day] else {return nil}
        return dayCount
    }
    /**
     * Returns the last commit date for a repo
     */
//    func lastCommitDate(repoId:String) -> DBDate?{
//        guard let repo = repos[repoId] else {return nil}
//        guard let lastYear:Int = repo.keys.max() else {return nil}
//        guard let lastMonth:Int = repo.keys.max() else {return nil}
//        guard let lastDay:Int = repo.keys.max() else {return nil}
//        //add day when that is included
//        return DBDate.init(year: lastYear, month: lastMonth, day:lastDay)
//    }
    /**
     * CommitCount for all repos in a speccific year in a speccific month
     * you can also do it for year, or day or even for every month etc.
     */
    func monthCount(year:Int,month:Int) -> Int{
        return repos.keys.reduce(0) {
            guard let commitCount = monthCount(repoId: $1, year: year, month: month) else {return $0}
            return $0 + commitCount
        }
    }
}
