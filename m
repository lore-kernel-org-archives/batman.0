Return-Path: <emin.savas@gohm.com.tr>
From: =?utf-8?B?RW1pbiBTYXZhxZ8=?= <emin.savas@gohm.com.tr>
Subject: Using two interfaces to increase bandwidth with bonding
MIME-Version: 1.0
Date: Wed, 21 Aug 2019 11:00:54 +0300
Message-Id: <368701566374454@myt2-a7d7570d35ff.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>

Greetings,
 
I want to ask about bonding feature. For example considering the following configuration;
 
PC0 ---> eth [100 mbits/s]                -----------------------------            eth [100 mbits/s]           <--- PC1
     |----> wifi_5ghz [110 mbits/s]       -----------------------------            wifi_5ghz [110 mbits/s]  <----|
 
 
       if the two interfaces(eth, wifi5ghz) are on the batman if I enable the bonding feature on both ends,
is it possible to see a bandwidth more than 100 mbits/s ?
 
 
Thanks in advance.
