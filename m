Return-Path: <don@dis.org.nz>
MIME-Version: 1.0
Date: Tue, 2 Oct 2012 09:53:08 +1300
Message-ID: <CAK+uisD5AddOnF+o5U4LdFu+7CAnNCJna8wBZL1huHqZyeLOfg@mail.gmail.com>
From: Donald Gordon <don@dis.org.nz>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] batman-adv on ethernet
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi

What happens if I add an interface to batman-adv (on which to exchange
mesh frames), and add that same interface to a bridge with bat0?  E.g.
on an openwrt, br-lan contains eth0, bat0 and wlan0; batman-adv is
exchanging mesh frames on wlan1 and eth0.

Will I end up with BATMAN-on-BATMAN or will batman-adv filter out the
batman frames it sees on bat0?

thanks

donald
