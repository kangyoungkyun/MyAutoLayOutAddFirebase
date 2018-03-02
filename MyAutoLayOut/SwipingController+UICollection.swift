
import UIKit

extension SwipingController{
   
    //컬렉션 뷰의 셀 사이사이마다 간격설정 원래는 디폴드 값으로 10이 지정되어 있음
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        print("minimumLineSpacingForSectionAt 진입")
        return 0
    }
    //컬렉션 뷰의 cell 개수 지정.
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("numberOfItemsInSection 진입")
        print(pages.count)
        return pages.count
    }
    //컬렉션 뷰의 cell을 구성하는 함수
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print("cellForItemAt 진입")
        print(pages.count)
        
        //위에서 등록해준 커스텀 셀을 가져와서 리턴해줌
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell
        let page = pages[indexPath.item]
        
        //view에 page 변수에 할당
        cell.page = page
        return cell
    }
    //커스텀 셀의 크기를 view에 꽉차게 해주었다.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("sizeForItemAt 진입")
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
}
