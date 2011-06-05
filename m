Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun,  5 Jun 2011 23:01:01 +0200
Message-Id: <1307307664-19910-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 0/3] Implement the AP-Isolation mechanism
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

This patchset introduces the AP-isolation functionality. As for common access
points, the AP-isolation is a mechanism that prevents clients to communicate
to each other. In batman-adv the AP-isolation, if activated, will prevent
"WIFI bridged-in clients" to communicate with any other "WIFI bridged-in
client".

The first patch introduces a mechanism which permit to detect the interface type
used by a client and to possibly mark its tt_local_entry in case of WIFI. This
information is then spread over the network within the TT announcements.

The other two patches implement the AP-isolation mechanism which exploits the
WIFI mark (on tt_entries) to prevent communications between WIFI clients.

The "AP-isolation check" is done either on the receiver and on the sender side.

Best regards,
	Antonio Quartulli


