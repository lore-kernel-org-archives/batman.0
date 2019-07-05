Return-Path: <moritzwarning@web.de>
From: Moritz Warning <moritzwarning@web.de>
Subject: Unknown symbol cfg80211_get_station
Message-ID: <cef22736-91db-6a22-6da4-35a4d53a4adc@web.de>
Date: Fri, 5 Jul 2019 16:51:56 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Hi,

on an AWS server I get this error:

$ modprobe batman-adv
$ dmesg
...
[ 1310.125438] batman_adv: Unknown symbol cfg80211_get_station (err 0)

$ uname -a
Linux ip-172-31-47-217 4.15.0-1032-aws #34-Ubuntu SMP Thu Jan 17 15:18:09 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
