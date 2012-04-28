Return-Path: <mmitar@gmail.com>
MIME-Version: 1.0
Date: Sun, 29 Apr 2012 01:56:02 +0200
Message-ID: <CAKLmikOLbh20g3j4UcKbBjhmvKsoXB9A0jHTR75NZLtuWBCtCQ@mail.gmail.com>
From: Mitar <mmitar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [B.A.T.M.A.N.] Batman with Ubiquiti SDK
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Jernej Kos <kostko@unimatrix-one.org>

Hi!

Ubiquiti provides OpenWrt based SDK for their firmware. To my
information, it contains some proprietary madwifi-based WiFi drivers
with some older OpenWrt version. My question is how it would be
possible to run Batman on top of their firmware (thus not latest
OpenWrt). As Batman is in kernel, is is enough kernel-backwards
compatible to be able to run also on older (2.6) kernel versions? For
olsrd it is much simpler: you just install olsrd package and this is
it.


Mitar
