Return-Path: <cmsv@wirelesspt.net>
Message-ID: <5133B0A6.6010306@wirelesspt.net>
Date: Sun, 03 Mar 2013 15:20:54 -0500
From: cmsv <cmsv@wirelesspt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] batctl.8 suggested correction.
Reply-To: cmsv@wirelesspt.net,
 The list for a Better Approach To Mobile Ad-hoc Networking
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

Having in mind that throughput and bandwidth are not the same and do not necessarily match; the use of the word "throughput" in batman-adv (Layer2) 
is misleading and can cause confusion when in measuring the real throughput on layer3 with L3 software.

As far as i know; at the moment batman-adv (L2) has no way to know what is the real throughput that the announced gateway bandwidth (l3) actually allows therefore the "
throughput" should be changed to announced bandwidth. 

Example:

              If the node is a gateway client the parameter will decide which
              criterias to consider when the batman-adv module has to choose
              between different internet connections announced by the afore-
              mentioned servers.
                        default: 20 -> late switch (TQ 20)
                       examples:  1 -> fast connection
                                       consider the gateway's advertised
                                       bandwidth as well as the link quality
                                       towards the gateway and stick with the
                                       selection until the gateway disappears
                                  2 -> stable connection
                                       chooses the gateway with the best link
                                       quality and sticks with it (ignore the
                                       advertised bandwidth)
                                  3 -> fast switch connection
                                       chooses the gateway with the best link
                                       quality but switches to another gateway
                                       as soon as a better one is found
                                 XX -> late switch connection
                                       chooses the gateway with the best link
                                       quality but switches to another gateway
                                       as soon as a better one is found which
                                       is at least XX TQ better than the cur-
                                       rently selected gateway (XX has to be a
                                       number between 3 and 256).


-- 






Redes wireless
http://wirelesspt.net

