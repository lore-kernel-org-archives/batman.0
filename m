Return-Path: <gui@altermundi.net>
Message-ID: <541C2B58.8070703@altermundi.net>
Date: Fri, 19 Sep 2014 10:10:48 -0300
From: Gui Iribarren <gui@altermundi.net>
MIME-Version: 1.0
References: <CAEbDFcQQMaRNam=ZWBqV4yOke2SZjE8JbpDNTQKcTzzHEz=Vhg@mail.gmail.com>
In-Reply-To: <CAEbDFcQQMaRNam=ZWBqV4yOke2SZjE8JbpDNTQKcTzzHEz=Vhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] traceroute help
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

On 19/09/14 09:43, Krishnathiepan Rasanayagam wrote:
> dear all,
> 
> do we have to follow different way than batctl 2012 version when we
> are using batctl traceroute 2014 ?
> 
>  I'm getting an error when trying to use batctl commands.

*which* error?

maybe you're trying to use batctl-2014 with a kernel module batadv-2012?
(not sure if that should work)

maybe you're on openwrt, and installed only "kmod-batman-adv" (which
used to include batctl tool) , but not the (relatively new) "batctl"
package?

cheers!
