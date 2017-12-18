Return-Path: <jorgepower99@gmail.com>
MIME-Version: 1.0
Sender: jorgepower99@gmail.com
From: jorge power <jorge@alumni.ufl.edu>
Date: Mon, 18 Dec 2017 15:55:48 -0500
Message-ID: <CAHuRCtSXTMBekv95iaoxVQtxGWLvk4HOz_SbOsn4WdXT9HpaFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [B.A.T.M.A.N.] Batman -adv no longer backwards compatible with
 kernels Pre -4.0???
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

I am running kernel 3.3.8 and trying to use batman adv ver 2017.4.
I am getting error:

net/batman-adv/hard-interface.c:101:28: error: 'const struct
rtnl_link_ops' has no member named 'get_link_net'

get_link_net is not part of rtnetlink.h in kernel v 3.3.8.
Is 2017.4 not backwards compatible with older kernels per 4.0?

get_link_net isnt added until kernel 4.0-rc1.

I saw a previous message from 2016 saying:
"Just to let everybody know: This patchset will break batman-adv compatibility
for kernels older than 4.0 (see d37512a277dfb2cef8a578e25a3246f61399a55a):"

Msg: https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-January/014306.html


So was the backwards compatability broken intentionally so its no
longer backwards compatible with older kernels?

What can i do?
-- 
Thanks
Jorge
