Return-Path: <a@unstable.cc>
Subject: Re: Passing VID-aware ethernet frames on plain batX interfaces
References: <CADJ1cURtCsWdy6rovfgb_XPhbsTc5epCv3yLgRCLcOVjfNSFdw@mail.gmail.com>
 <38142483.hY40ij8To5@ripper>
 <CADJ1cUQZ2YqFSVj=SNhPcC_sOjy+AkrEr=dQ=8T_0HegFou=Hw@mail.gmail.com>
 <4337705.76P5Ur0oAU@sven-edge>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <97828d35-e1a9-9766-6e5b-7476a55e4014@unstable.cc>
Date: Mon, 14 Sep 2020 08:35:34 +0200
MIME-Version: 1.0
In-Reply-To: <4337705.76P5Ur0oAU@sven-edge>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Sven Eckelmann <sven@narfation.org>, Alessandro Bolletta <abolletta@netter.io>

On 11/09/2020 16:02, Sven Eckelmann wrote:
> Maybe Antonio wants to add more things to this discussion.

I believe you and Simon have already been fairly exhaustive.

batman-adv simply won't forward any VLAN tagged traffic to nodes that
don't have that specific VLAN set up.

That's because batman-adv will instantiate a number of internal data
structures, along with routing logic, only when the VLAN is created.

Regards,

-- 
Antonio Quartulli
