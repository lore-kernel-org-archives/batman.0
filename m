Return-Path: <keith.chew@gmail.com>
MIME-Version: 1.0
Date: Thu, 22 Oct 2015 11:07:48 +1300
Message-ID: <CAKaWdxbrS90fbV4if4ZhRYtdL-neikMc4iVb_EtowJf8M=9dvg@mail.gmail.com>
From: Keith Chew <keith.chew@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [B.A.T.M.A.N.] Alfred GPS higher update rate
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

Hi

I am experimenting with using Alfred on a group of drones (initially
10 units) to send their GPS locations to each other.

The drones will be connected via batman-adv on WIFI, and each of them
read the GPS every 200ms (5Hz).

I would like to change alfred-gpsd from updating the GPS coordinates
every 10s to 200ms.

Does anyone see any issues with this change? ie it is even feasible/practical?

Regards
Keith
