Return-Path: <tonyputi@gmail.com>
MIME-Version: 1.0
From: Filippo Sallemi <tonyputi@gmail.com>
Date: Sat, 19 Nov 2011 11:43:40 +0100
Message-ID: <CAFevQmPcoR3O5FHfHvuUkv4yrJMYd1MtsEMNZ24uwjXaUtXxeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [B.A.T.M.A.N.] batctl ping exit status
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

Hi all,
I'm working on a simple script that check if node is connected. The
scope of this script is make every node able to autorescue in case of
change channel on some gateway node.
To do this check if i'm not a gateway try to ping my gateway ipaddress
then if it not respond try to batctl ping my gateway mac and than if
not respond for a number of tries the node try to find another
channell with the same bssid.
The problem is that batct ping every time exit with status 0 istead of
behaviour of ping command that exit with 1 if ping fail. At this time
I have to use some regex to check if batctl ping status command. It is
possible to fix batctl ping to work such as ping command?

Rgds

-- 
Filippo Sallemi
