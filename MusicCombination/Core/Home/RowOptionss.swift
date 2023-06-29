//
//  RowOptionss.swift
//  MusicCombination
//
//  Created by MyBook on 12.07.2022.
//

import SwiftUI

struct RowOptionss: View {
    var body: some View {
        VStack(spacing: 2) {
            HStack(spacing: 1) {
                Circle()
                    .opacity(0)
                Circle()
                    .frame(width: 10, height: 10)
                    
            }
            .padding(.leading, 5)
            .padding(.top, 3)
            HStack(spacing: 1) {
                Circle()
                    .frame(width: 10, height: 10)
                Circle()
                    .opacity(0)
            }
            .padding(.trailing, 3)
            HStack(spacing: 1) {
                Circle()
                    .frame(width: 10, height: 10)
                Circle()
                    .opacity(0)
            }
            .padding(.trailing, 3)
            HStack(spacing: 1) {
                Circle()
                    .opacity(0)
                Circle()
                    .frame(width: 10, height: 10)
            }
            .padding(.bottom, 5)
            .padding(.leading, 5)
        }
        .frame(width: 20, height: 40)
    }
}

struct RowOptionss_Previews: PreviewProvider {
    static var previews: some View {
        RowOptionss()
    }
}
