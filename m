Return-Path: <russell@personaltelco.net>
References: <1390299725-1873-1-git-send-email-antonio@meshcoding.com>
 <86mwipch0u.fsf@coulee.tdb.com> <86lhy8pn5v.fsf@coulee.tdb.com>
 <52DF7556.9090200@makrotopia.org> <86y527oqpl.fsf_-_@coulee.tdb.com>
 <52E003DD.6040302@meshcoding.com> <52E02EDC.3080805@wirelesspt.net>
 <86iotbo9hw.fsf@coulee.tdb.com> <52E05E0F.7010203@wirelesspt.net>
 <52E08DFE.9030604@makrotopia.org> <52E5063E.3080408@makrotopia.org>
 <52E51A04.8020800@meshcoding.com> <52E5322D.60202@wirelesspt.net>
 <52E532D0.2000907@meshcoding.com> <52E5341F.30800@meshcoding.com>
 <52E69D7D.80905@wirelesspt.net> <861tzsgaub.fsf@coulee.tdb.com>
 <52E70836.3050502@wirelesspt.net>
From: Russell Senior <russell@personaltelco.net>
Date: Wed, 29 Jan 2014 00:10:18 -0800
In-Reply-To: <52E70836.3050502@wirelesspt.net> (cmsv@wirelesspt.net's message
 of "Mon\, 27 Jan 2014 20\:30\:30 -0500")
Message-ID: <867g9jciol.fsf@coulee.tdb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [B.A.T.M.A.N.] batman-adv: memory leak?
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
To: cmsv@wirelesspt.net
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

>>>>> "cmsv" == cmsv  <cmsv@wirelesspt.net> writes:


>> Can you paste your feeds.conf file?

cmsv> Of course:


cmsv> for AA and batman-adv 2014.0.0 in feeds.default.conf

cmsv> src-svn packages svn://svn.openwrt.org/openwrt/branches/packages_12.09 
cmsv> src-git routing git://github.com/openwrt-routing/packages.git


cmsv> For the hostapd and mentioned mac80211 you will need to clone
cmsv> git clone git://git.openwrt.org/12.09/openwrt.git

cmsv> Then obtain the specific revisions and replace the original
cmsv> hostapd and mac80211 from AA.

I am not following exactly.  Do you know which change in particular
makes the memory leak come and go?  AA implies an older kernel, 3.3.8
or something.

Also, obtain specific revisions from trunk? and then copy
them into the AA tree?  

package/kernel/mac80211 r39150 = commit 886b3c876b71122ed9523834488f373908224663
package/network/services/hostapd r39155 = commit 64820db4b264472e03acb9ea6b5536fa7633a8ca

Is that right?  Do those mac80211/hostapd revisions come from
bisection (i.e. the last "good" rev) or happenstance?

Thanks for clarification!


-- 
Russell Senior, President
russell@personaltelco.net
