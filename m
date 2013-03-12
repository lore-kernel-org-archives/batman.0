Return-Path: <ajeetbbr@gmail.com>
MIME-Version: 1.0
Date: Tue, 12 Mar 2013 11:25:18 +0530
Message-ID: <CAHQ_bginU7MXj-EAiy9PUEaWXC0JWTD-1ZbaEH6K4VLad2t89g@mail.gmail.com>
From: ajeet singh <ajeetbbr@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] Ping related issue in batman-adv-2013.0.0
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

Hello All,

I am getting a problem with batman-adv-2013.0.0,

Please find the details,

I have two batman-adv nodes A and B,

Initial setup:
A (bat0: 192.0.0.1) ---------- B (bat0: 192.0.0.2)
Ping is working properly between node A and node B.

Setup after restarting B:
 A (bat0: 192.0.0.1) ---------- B (bat0: 192.0.0.2)
After restarting node B, I am setting the same IP as previously to B
(192.0.0.2) but this node (B) is not reachable from A for quite some
time.

Note: If I assign some other IP to B after restart for example
192.0.0.3, node A is able to ping B without any delay.

Please let me know this is the problem due to DAT or something else.

Thanks
Ajeet
