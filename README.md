# Data.Taipei#

這個是使用台北市政府的 Open data API 的程式庫，</br>
我為了能在 iOS 上方便使用而建立的。

## 如何使用##
複製 *DataTaipeiAPI for iOS* 這個資料夾到你的專案底下即可，</br>
在需要使用它的地方 <code>#import "DataTaipei.h"</code>
###查詢資料集###
資料集的 Class 名稱為 DTADataCollection，</br>
你可以透過 searchKeyword 對資料集進行查詢的動作，</br>
範例如下：

``` objective-c
DTAQueryResultBlock resultBlock = ^(NSString *resultString, NSError *error) {
	if (error != nil) {
	NSLog(@"%@", error);        
	return;
	}    
	NSLog(@"%@", resultString);
};
    
DTADataCollection *dataCollection = [DTADataCollection defaultInstance];
[dataCollection setSearchKeyword:keyword];
[dataCollection queryDataCollectionWithResultBlock:resultBlock];
```
###取得檔案內容###
取得檔案內容的 Class 的名稱為 DTADataResource，</br>
你可以使用它進行資料的取得與下載，</br>
在使用前你必須提供 **RID** 給 DataTaipei Calss ，用法如下：

``` objective-c
[DataTaipei setRIDKey:@"你要取得的RID資訊"];
```
RID 資訊可以從資料集取得，或是到 [Data.Taipei](http://data.taipei) 查詢你要取得的資料。</br>
提供 RID 之後就可以直接取得資料內容，你可以透過 -queryResourceDataWithResultBlock: 取得文字資訊或是</br>
  -downloadResourceDataForSavePath:withResult: 下載資訊，</br>
你也可以透過 responseFormat 來更改取得資料的類型，</br>
範例如下：

``` objective-c
DTAQueryResultBlock resultBlock = ^(NSString *resultString, NSError *error) {
	if (error != nil) {
		NSLog(@"%@", error);
		return;
	}
   
	NSLog(@"%@", resultString);
};
    
DTADataResource *dataResouce = [DTADataResource defaultInstance];
[dataResouce queryResourceDataWithResultBlock:resultBlock];
```

##其他資訊##
可運行在 iOS 7.0 以上系統。</br>
相容於 Swift 的 option variable。</br>
