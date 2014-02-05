Return-Path: <daniel@makrotopia.org>
Message-ID: <52F2968D.8050101@makrotopia.org>
Date: Wed, 05 Feb 2014 20:52:45 +0100
From: Daniel <daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] question regarding gateway_mode server
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
Cc: Ufo <ufo@public-ip.org>

Hi!

Is there a way how I can prevent a local DHCP-server from replying to
non-gw_mode-client's DHCP requests?
The situation is that we got a central DHCP server on the mesh which should be
used by all nodes which do not have gw_mode set. In my understanding, setting
gw_mode to 'server' on another local DHCP server should prevent that DHCP server
from receiving (and thus replying to) requests from clients with gw_mode set to
'off', however, it seems like the local gw_mode==server node occasionally
replies to gw_mode==off clients (seems like the usual
more-than-one-dhcp-server-on-a-subnet race condition)
I'm aware that this could probably be solved using ebtables, however, due to the
high performance impact and ugliness of ebtables, I'd prefer another way to fix it.
Am I getting something wrong regarding the intended behavior of gw_mode==server?
If needed, I can write a patch to implement that functionality and have a
gw_mode==exclusive_server or something like that in case the current behavior is
actually intentional.

(We are using batman-adv v14 (2013.4.0) on various OpenWrt versions.)


Cheers


Daniel

