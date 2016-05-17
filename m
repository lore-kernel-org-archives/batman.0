Return-Path: <patrick.d.bosch@googlemail.com>
MIME-Version: 1.0
Date: Tue, 17 May 2016 10:08:09 +0200
Message-ID: <CACJ=Gam2D_mQX2jSBF5xBJ_A+itm-j9Q9_XKTNg4gZdK_wnhbg@mail.gmail.com>
Subject: How to read batadv-vis jsondoc correctly
From: Patrick Bosch <patrick.d.bosch@googlemail.com>
Content-Type: text/plain; charset=UTF-8
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

Hi all

As the title suggest, I'm wondering how to read the jsondoc output
correctly. It seems that every possible link is included in that
output, but which one is the one that is used? If there is one link,
it should be the one with the lowest metric, but what if a node has
more than one link?

For example the following setup:

Node 1
     |
     |
Node 2 ------- Node 3

Here, node two would have two links. Now, if there would be some more
nodes that are in the jsondoc output, how can I find out which are the
links that are in use?

Thanks in advance for the help!

Kind regards
Patrick
