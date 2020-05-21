Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
MIME-Version: 1.0
From: Alexey Ermakov <axel101@gmail.com>
Date: Thu, 21 May 2020 20:13:18 +0300
Message-ID: <CAOVt3fEEaLx8-58NjVXU0L6XToB5FPvGjFaEoZBeRCL+Eh-QWw@mail.gmail.com>
Subject: Batman-adv packet retranslation
Content-Type: text/plain; charset="UTF-8"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

Hi, All.

There is a problem with retranslating packets in B.A.T.M.A.N. V mode.
I have 3 stations, st1, st2 and st3 with one active network interface.
This interface is configured so that st1 and st3 can see only st2.
I expect that if I join these stations in a bat0 network, then station
2 will act as a repeater and all three stations will be visible in the
bat0 network.
This works fine if I selecting B.A.T.M.A.N. IV algorithm, but doesn't
work in B.A.T.M.A.N.V.

--
Ermakov Alexey.
