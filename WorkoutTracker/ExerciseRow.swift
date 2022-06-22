//
//  ExerciseRow.swift
//  WorkoutTracker
//
//  Created by utente on 21/06/22.
//

import SwiftUI

struct ExerciseRow: View {
    var name: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: self.action) {
            HStack {
                Text(self.name)
                if self.isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

struct ExerciseRow_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseRow(name: "Push Up", isSelected: false) {
            return
        }
    }
}
