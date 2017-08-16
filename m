Return-Path: <dandenson@gmail.com>
MIME-Version: 1.0
From: dan <dandenson@gmail.com>
Date: Wed, 16 Aug 2017 09:43:34 -0600
Message-ID: <CAA_JP8WFZPzDzFLAAOydhjuL7Ex26_RtbnH-pEhaCe4Fs70FEA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [B.A.T.M.A.N.] batman on top of vlan?
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

Can batman operate on top of a vlan?  For example, a wireless link
with MTU of 1532 to accommodate both batman and the vlan.  Plugs into
the batman-adv box on eth0, configure eth0.10 and add eth0.10 to bat0.

This is meant to solve a specific issue of needing non-batman-adv
access to the radio web-ui's on the native/untagged vlan1

thanks.
