//
//  RxMJRefresh+MarsEx.swift
//  MarsUIKit
//
//  Created by Teng Fei on 2022/11/14.
//

#if os(iOS)
import UIKit
#if canImport(RxCocoa) && canImport(RxSwift) && canImport(MJRefresh)
import RxCocoa
import RxSwift
import MJRefresh

extension Reactive where Base: MJRefreshComponent {
    
    public var ms_refreshing: ControlEvent<Void> {
        let source: Observable<Void> = Observable.create { [weak control = self.base] observer in
            if let control = control {
                control.refreshingBlock = {
                    // Delay to execute the refresh animation.
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        observer.on(.next(()))
                    }
                }
            }
            return Disposables.create()
        }
        return ControlEvent(events: source)
    }
    
}

public enum MarsRefreshAction: CustomStringConvertible {
    case none
    case beginRefreshing
    case endRefreshing
    case endRefreshingWithNoMoreData
    case resetNoMoreData
    
    public var description: String {
        switch self {
        case .none: return "None"
        case .beginRefreshing: return "BeginRefreshing"
        case .endRefreshing: return "EndRefreshing"
        case .endRefreshingWithNoMoreData: return "EndRefreshingWithNoMoreData"
        case .resetNoMoreData: return "ResetNoMoreData"
        }
    }
}

extension Reactive where Base: UIScrollView {
    
    public var ms_refreshAction: Binder<MarsRefreshAction> {
        return Binder(base) { target, action in
            switch action {
            case .beginRefreshing:
                target.mj_header?.beginRefreshing()
            case .endRefreshing:
                target.mj_header?.endRefreshing()
                target.mj_footer?.endRefreshing()
            case .endRefreshingWithNoMoreData:
                target.mj_footer?.endRefreshingWithNoMoreData()
            case .resetNoMoreData:
                target.mj_footer?.resetNoMoreData()
            case .none: break
            }
        }
    }
    
}

#endif
#endif
