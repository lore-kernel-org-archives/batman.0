Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: can B.A.T.M.A.N. force a path through the network?
From: giorgi.flavio.at@gmail.com
Date: Tue, 12 Oct 2021 10:03:35 -0000
Message-ID: <20211012100335.1201.63878@diktynna.open-mesh.org>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

Hi, I'm currently using B.A.T.M.A.N. to link 4 raspberry pi.
I set up the network and it works correctly, the devices see each other and they can communicate.
The problem is that I need to force the packets to follow a specified path through the network.
For example, I need that a packet from device 1, goes through device 2 then 3, and finally 4.
Since the protocol works at layer 2 it is not possible to change the IP routing tables. 
So my question is, is it possible to do something like this using B.A.T.M.A.N.?

Thank you in advance.
Best regards.
Flavio
