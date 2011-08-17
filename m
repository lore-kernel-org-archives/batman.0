Return-Path: <john.tobias.ph@gmail.com>
MIME-Version: 1.0
Date: Tue, 16 Aug 2011 19:10:29 -0700
Message-ID: <CACUGKYOvkhxWzR4SxAkX33Gsz6AK0cY6HZLjOjn5n5BNevPahw@mail.gmail.com>
From: John Tobias <john.tobias.ph@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] Configuring batman
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hi Guys,

I have two devices, both of them have eth0, wlan0. I followed the
BATMAN quick start guide
(http://www.open-mesh.org/wiki/batman-adv/Quick-start-guide) mixing
non-BATMAN.
The bat0, eth0, wlan0 on both devices were set to 0.0.0.0 and the
mesh-bridge on dev1 was set to 192.168.10.1 and on dev2 was set to
192.168.10.2. Both devices can ping to each other.

When I execute "batctl gwl", I was getting "No gateways in range ...".

My question is, do you have a sample step-by-step procedures to bring
up the batman correctly?.

Regards,

john
