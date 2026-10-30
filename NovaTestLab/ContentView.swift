import SwiftUI
import UIKit

struct ContentView: View {
    @State private var selectedTab = 0
    var body: some View {
        ZStack {
            Color(red: 0.035, green: 0.055, blue: 0.10).ignoresSafeArea()
            Group {
                switch selectedTab {
                case 0: DashboardView()
                case 1: ToolsView()
                default: SettingsView()
                }
            }
        }
        .preferredColorScheme(.dark)
        .safeAreaInset(edge: .bottom) {
            HStack {
                tab("square.grid.2x2.fill", "Home", 0)
                tab("wrench.and.screwdriver.fill", "Tools", 1)
                tab("gearshape.fill", "Settings", 2)
            }
            .padding(.top, 12).padding(.bottom, 8)
            .background(.ultraThinMaterial)
        }
    }
    private func tab(_ icon: String, _ title: String, _ index: Int) -> some View {
        Button { selectedTab = index } label: {
            VStack(spacing: 5) {
                Image(systemName: icon).font(.system(size: 18, weight: .semibold))
                Text(title).font(.caption2.weight(.semibold))
            }
            .foregroundStyle(selectedTab == index ? Color.cyan : Color.white.opacity(0.55))
            .frame(maxWidth: .infinity)
        }
    }
}

struct DashboardView: View {
    @State private var count = 0
    @State private var completed = false
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("NOVA TEST LAB").font(.caption.weight(.bold)).tracking(2).foregroundStyle(.cyan)
                        Text("Xin chào 👋").font(.system(size: 30, weight: .bold))
                        Text("Không gian thử nghiệm iOS của bạn").foregroundStyle(.white.opacity(0.6))
                    }
                    Spacer()
                    Image(systemName: "sparkles").font(.system(size: 25)).foregroundStyle(.cyan)
                        .frame(width: 54, height: 54).background(.cyan.opacity(0.12), in: RoundedRectangle(cornerRadius: 18))
                }
                HStack(spacing: 12) {
                    metric("APP STATUS", "ONLINE", "checkmark.circle.fill", .green)
                    metric("BUILD", "1.0.0", "hammer.fill", .cyan)
                }
                VStack(alignment: .leading, spacing: 14) {
                    Text("BỘ ĐẾM TƯƠNG TÁC").font(.caption.weight(.bold)).tracking(1.3).foregroundStyle(.white.opacity(0.6))
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(count)").font(.system(size: 48, weight: .bold, design: .rounded))
                            Text("Lượt nhấn đã ghi nhận").font(.subheadline).foregroundStyle(.white.opacity(0.55))
                        }
                        Spacer()
                        Button { count += 1 } label: {
                            Image(systemName: "plus").font(.title2.bold()).frame(width: 58, height: 58)
                                .background(LinearGradient(colors: [.cyan, .blue], startPoint: .topLeading, endPoint: .bottomTrailing), in: Circle())
                        }
                    }
                    HStack {
                        Button("Giảm") { count = max(0, count - 1) }.buttonStyle(SecondaryButtonStyle())
                        Button("Đặt lại") { count = 0 }.buttonStyle(SecondaryButtonStyle())
                    }
                }.padding(20).panel()
                VStack(alignment: .leading, spacing: 13) {
                    Text("CHECKLIST KIỂM THỬ").font(.caption.weight(.bold)).tracking(1.3).foregroundStyle(.white.opacity(0.6))
                    checklistRow("Giao diện hiển thị", detail: "Kiểm tra layout và màu sắc", done: true)
                    checklistRow("Tương tác nút bấm", detail: "Thử bộ đếm ở phía trên", done: true)
                    Button { completed.toggle() } label: {
                        HStack(spacing: 12) {
                            Image(systemName: completed ? "checkmark.circle.fill" : "circle")
                                .foregroundStyle(completed ? .green : .white.opacity(0.4))
                            VStack(alignment: .leading, spacing: 3) {
                                Text("Kiểm tra tuỳ chọn").foregroundStyle(.white)
                                Text("Bật/tắt và lưu trạng thái trong phiên").font(.caption).foregroundStyle(.white.opacity(0.5))
                            }
                            Spacer()
                        }
                    }
                }.padding(20).panel()
                Text("Nova Test Lab • Built with SwiftUI").font(.caption).foregroundStyle(.white.opacity(0.35)).frame(maxWidth: .infinity)
            }.padding(20)
        }
    }
    private func metric(_ title: String, _ value: String, _ icon: String, _ color: Color) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: icon).foregroundStyle(color).font(.title3)
            Text(value).font(.title2.bold())
            Text(title).font(.caption2.weight(.bold)).foregroundStyle(.white.opacity(0.5))
        }.frame(maxWidth: .infinity, alignment: .leading).padding(16).panel()
    }
    private func checklistRow(_ title: String, detail: String, done: Bool) -> some View {
        HStack(spacing: 12) {
            Image(systemName: done ? "checkmark.circle.fill" : "circle").foregroundStyle(done ? .green : .gray)
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                Text(detail).font(.caption).foregroundStyle(.white.opacity(0.5))
            }
            Spacer()
        }
    }
}

struct ToolsView: View {
    @State private var text = ""
    @State private var items = ["Kiểm tra điều hướng", "Kiểm tra nút bấm", "Kiểm tra giao diện"]
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                header("Test Tools", subtitle: "Các công cụ để bạn thử nghiệm")
                VStack(alignment: .leading, spacing: 12) {
                    Text("TODO TESTER").font(.caption.bold()).tracking(1.2).foregroundStyle(.cyan)
                    HStack {
                        TextField("Nhập công việc cần test...", text: $text)
                            .textFieldStyle(.roundedBorder)
                        Button { addItem() } label: { Image(systemName: "plus").font(.headline).padding(12).background(.cyan, in: RoundedRectangle(cornerRadius: 10)).foregroundStyle(.black) }
                    }
                    ForEach(items, id: \.self) { item in
                        HStack {
                            Text(item).font(.subheadline)
                            Spacer()
                            Button(role: .destructive) { items.removeAll { $0 == item } } label: { Image(systemName: "trash").foregroundStyle(.red) }
                        }.padding(.vertical, 7)
                        Divider().overlay(.white.opacity(0.1))
                    }
                    if items.isEmpty { Text("Chưa có công việc. Hãy thêm một mục mới!").font(.caption).foregroundStyle(.white.opacity(0.5)) }
                }.padding(18).panel()
                VStack(alignment: .leading, spacing: 12) {
                    Text("DEVICE INFO").font(.caption.bold()).tracking(1.2).foregroundStyle(.cyan)
                    info("Hệ điều hành", value: "iOS \(UIDevice.current.systemVersion)")
                    info("Thiết bị", value: UIDevice.current.model)
                    info("Ứng dụng", value: "Nova Test Lab")
                }.padding(18).panel()
            }.padding(20)
        }
    }
    private func addItem() {
        let value = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !value.isEmpty else { return }
        items.insert(value, at: 0); text = ""
    }
    private func info(_ key: String, value: String) -> some View {
        HStack { Text(key).foregroundStyle(.white.opacity(0.55)); Spacer(); Text(value).fontWeight(.semibold) }
    }
}

struct SettingsView: View {
    @State private var notifications = true
    @State private var haptics = false
    @State private var compact = false
    var body: some View {
        Form {
            Section("Tuỳ chọn ứng dụng") {
                Toggle("Thông báo thử nghiệm", isOn: $notifications)
                Toggle("Rung phản hồi", isOn: $haptics)
                Toggle("Giao diện thu gọn", isOn: $compact)
            }
            Section("Thông tin") {
                LabeledContent("Tên ứng dụng", value: "Nova Test Lab")
                LabeledContent("Phiên bản", value: "1.0.0")
                LabeledContent("Framework", value: "SwiftUI")
            }
            Section {
                Text("Đây là ứng dụng demo để kiểm tra giao diện và luồng tương tác.").font(.footnote).foregroundStyle(.secondary)
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color(red: 0.035, green: 0.055, blue: 0.10))
        .navigationTitle("Settings")
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label.font(.subheadline.weight(.semibold))
            .frame(maxWidth: .infinity).padding(.vertical, 12)
            .background(.white.opacity(configuration.isPressed ? 0.16 : 0.08), in: RoundedRectangle(cornerRadius: 12))
    }
}
extension View {
    func panel() -> some View {
        self.background(Color.white.opacity(0.055), in: RoundedRectangle(cornerRadius: 22))
            .overlay(RoundedRectangle(cornerRadius: 22).stroke(.white.opacity(0.08), lineWidth: 1))
    }
}
func header(_ title: String, subtitle: String) -> some View {
    VStack(alignment: .leading, spacing: 6) {
        Text(title).font(.system(size: 30, weight: .bold))
        Text(subtitle).foregroundStyle(.white.opacity(0.55))
    }.frame(maxWidth: .infinity, alignment: .leading)
}
