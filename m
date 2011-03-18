Return-Path: <batman@kevinsteen.net>
Message-ID: <4D839294.9030103@kevinsteen.net>
Date: Fri, 18 Mar 2011 17:12:52 +0000
From: Kevin Steen <batman@kevinsteen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Software editing of /etc/network/interfaces ?
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
To: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>

Anyone know if there are existing script functions to allow a Debian 
package to edit/add entries to /etc/network/interfaces ?

I'm trying to create a package which someone can install to get them on 
the mesh, rather than a list of instructions on what to edit, etc. The 
key thing (AFAIK) is making sure everyone is on the same BSSID and channel.

Anyone created this package for a batman_adv network already?

On a related note, is the on-air format for batman_adv reasonably stable 
at the moment? If thousands of FreedomBoxen[1] were to start using it, 
what's the likelihood they would all have to upgrade to a new wire 
format in the near future?

1. http://wiki.debian.org/FreedomBox

Thanks
-Kevin

