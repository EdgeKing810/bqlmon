Name:           bqlmon
Version:        1.0
Release:        1%{?dist}
Summary:        Byte Queue Limits monitor

License:        BSD-2-Clause
URL:            https://github.com/ffainelli/bqlmon
Source0:        https://github.com/ffainelli/bqlmon

BuildRequires:  gcc
BuildRequires:  make
BuildRequires:  ncurses
BuildRequires:  ncurses-devel

%description
This program uses the Linux Byte Queue Limits support that some Linux Ethernet drivers do support.
Byte Queue Limits is refered to below as BQL. The program provides a ncurses interface to monitor
the current number of bytes in-flight in the queue.

%prep
%setup -q
%global debug_package %{nil}

%build
make %{?_smp_mflags}

%install
%make_install

%files
%license LICENSE
%{_bindir}/%{name}

%changelog
* Tue Feb 21 2023 Kishan Takoordyal <kishan@cyberstorm.mu> - 1.0-1
- First Release
