From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] two-way-tunnel quirks
Date: Sun, 2 Dec 2007 19:54:24 +0100
References: <20071130232852.GC3934@apoderado.ometepe.net>
	<200712011834.54327.lindner_marek@yahoo.de>
	<20071202043216.GB3923@apoderado.ometepe.net>
In-Reply-To: <20071202043216.GB3923@apoderado.ometepe.net>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="Boundary-01=_g9vUHd0fISwup7b"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200712021954.24310.axel@open-mesh.net>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

--Boundary-01=_g9vUHd0fISwup7b
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit

Hello,

...
>
> > - Can you describe it in way that i can reproduce it ?
>
>   A---B---C
>
> A: your computer
>
> B: bmxd_rv804  client node      }
>                                  }running 2-way-tunnel
> C: bmxd_rv804    gw node        }

I am just curious, can you confirm if the following correctly 
describes the HNA/SNAT of your setup:

for the two-way-tunnel setup:
 - you were doing SNAT at Cs' upstream interface AND at Bs' bat0 interface 

for the one-way tunnel setup:
 - you are only doing SNAT at Cs' upstream interface 
 - and additionally an HNA announcement by B for the address used by A

thanks,
axel
--Boundary-01=_g9vUHd0fISwup7b
Content-Type: text/html;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit

<html><head><meta name="qrichtext" content="1" /></head><body style="font-size:10pt;font-family:Bitstream Vera Sans Mono">
<p>Hello,</p>
<p></p>
<p>...</p>
<p>&gt;</p>
<p>&gt; &gt; - Can you describe it in way that i can reproduce it ?</p>
<p>&gt;</p>
<p>&gt;   A---B---C</p>
<p>&gt;</p>
<p>&gt; A: your computer</p>
<p>&gt;</p>
<p>&gt; B: bmxd_rv804  client node      }</p>
<p>&gt;                                  }running 2-way-tunnel</p>
<p>&gt; C: bmxd_rv804    gw node        }</p>
<p></p>
<p>I am just curious, can you confirm if the following correctly </p>
<p>describes the HNA/SNAT of your setup:</p>
<p></p>
<p>for the two-way-tunnel setup:</p>
<p> - you were doing SNAT at Cs' upstream interface AND at Bs' bat0 interface </p>
<p></p>
<p>for the one-way tunnel setup:</p>
<p> - you are only doing SNAT at Cs' upstream interface </p>
<p> - and additionally an HNA announcement by B for the address used by A</p>
<p></p>
<p>thanks,</p>
<p>axel</p>
</body></html>
--Boundary-01=_g9vUHd0fISwup7b--
