Message-ID: <a934d3f30804092359m33d3c3e3rb84b29914e66c1ff@mail.gmail.com>
Date: Thu, 10 Apr 2008 02:59:46 -0400
From: "Vinay Menon" <vinaymenon@gmail.com>
Subject: Re: [B.A.T.M.A.N.] AHdemo mode
In-Reply-To: <200804101504.48485.bruno@thinktube.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_1504_33105667.1207810786055"
References: <200804092052.12389.gfjl@ubbi.com>
	<E3C3B297-FD0F-4708-AA7D-AEA1F979EA70@gmail.com>
	<200804101222.16445.lindner_marek@yahoo.de>
	<200804101504.48485.bruno@thinktube.com>
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

------=_Part_1504_33105667.1207810786055
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

ditto bruno .

End to end encryption for clients is better done with openssl .
Having to choose our gateway too is similar to having to choose then option
or having secure routing or not more over .Entering the prefered gateway is
same as entering preferred password the password is more dynamic and a bit
more secure imo .
If the admin wants he can secure the system and if its a open mesh then no
need of security.....well oss is all about options isnt it?

Regards,

On Thu, Apr 10, 2008 at 2:04 AM, bruno randolf <bruno@thinktube.com> wrote:

> On Thursday 10 April 2008 13:22:16 Marek Lindner wrote:
> > IMHO the olsr secure plugin idea has a good intention but the concept is
> > broken. There are several aspects:
> > - As long as only a single instance (one admin) knows the key everything
> is
> > fine. But every node joining the mesh will need that key. Either the
> admin
> > has a _lot_ of freetime or you have to hand out the key. In the later
> case
> > check Ebay from to time to time to find out about the value of your key.
>
> still that can be better than no security at all...
>
> > ;-) - Furthermore, batman is used for _community_ meshing. Everybody
> should
> > be able to join quickly ...
>
> i basically agree, but some people might like to set up a more controlled
> environment. even in a community network this might be useful at times,
> for
> example if you want to set up a backbone network.
>
> one way to solve this without a static key which has to be known to all
> nodes
> is using a public key infrastructure (PKI) with a certificate authority
> (CA).
> the clients can generate their own private and public keys and send the
> public key to be signed by the CA. that could go hand in hand with adding
> their nodes to a map and accepting some basic agreement (pico peering).
> after
> it has been signed they could start using encryption for an extra level of
> mesh security.
>
> > - You give your users a FALSE impression of security: "We have the
> secure
> > plugin enabled - we are secure!". Still everybody can sniff the data,
> man
> > in the middle, etc
>
> yes people have to understand that only the mesh protocol will be
> encrypted,
> not the data.
>
> > - Encryption on an embedded device like a router is a performance killer
> if
> > the encryption is not done in the hardware itself.
>
> it's not too bad as long as the bandwith is low, as it would be the case
> with
> protocol traffic.
>
> > - Most important: Nothing is better than end to end encryption /
> > authentication / authorization.
>
> that's true, but it doesn't help if the underlying mesh protocol can be
> disturbed easily by un-authenticated nodes and your traffic never reaches
> the
> other endpoint.
>
> there are two different layers of adding authentication and encryption.
> one is
> the mesh protocol itself the other one is end-to-end user encryption. both
> are necessary if you want to make your network secure.
>
> bruno
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>



-- 
Vinay Menon

------=_Part_1504_33105667.1207810786055
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

ditto bruno .<br><br>End to end encryption for clients is better done with openssl .<br>Having to choose our gateway too is similar to having to choose then option or having secure routing or not more over .Entering the prefered gateway is same as entering preferred password the password is more dynamic and a bit more secure imo .<br>
If the admin wants he can secure the system and if its a open mesh then no need of security.....well oss is all about options isnt it?<br><br>Regards,<br><br><div class="gmail_quote">On Thu, Apr 10, 2008 at 2:04 AM, bruno randolf &lt;<a href="mailto:bruno@thinktube.com">bruno@thinktube.com</a>&gt; wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class="Ih2E3d">On Thursday 10 April 2008 13:22:16 Marek Lindner wrote:<br>
&gt; IMHO the olsr secure plugin idea has a good intention but the concept is<br>
&gt; broken. There are several aspects:<br>
&gt; - As long as only a single instance (one admin) knows the key everything is<br>
&gt; fine. But every node joining the mesh will need that key. Either the admin<br>
&gt; has a _lot_ of freetime or you have to hand out the key. In the later case<br>
&gt; check Ebay from to time to time to find out about the value of your key.<br>
<br>
</div>still that can be better than no security at all...<br>
<br>
&gt; ;-) - Furthermore, batman is used for _community_ meshing. Everybody should<br>
<div class="Ih2E3d">&gt; be able to join quickly ...<br>
<br>
</div>i basically agree, but some people might like to set up a more controlled<br>
environment. even in a community network this might be useful at times, for<br>
example if you want to set up a backbone network.<br>
<br>
one way to solve this without a static key which has to be known to all nodes<br>
is using a public key infrastructure (PKI) with a certificate authority (CA).<br>
the clients can generate their own private and public keys and send the<br>
public key to be signed by the CA. that could go hand in hand with adding<br>
their nodes to a map and accepting some basic agreement (pico peering). after<br>
it has been signed they could start using encryption for an extra level of<br>
mesh security.<br>
<div class="Ih2E3d"><br>
&gt; - You give your users a FALSE impression of security: &quot;We have the secure<br>
&gt; plugin enabled - we are secure!&quot;. Still everybody can sniff the data, man<br>
&gt; in the middle, etc<br>
<br>
</div>yes people have to understand that only the mesh protocol will be encrypted,<br>
not the data.<br>
<div class="Ih2E3d"><br>
&gt; - Encryption on an embedded device like a router is a performance killer if<br>
&gt; the encryption is not done in the hardware itself.<br>
<br>
</div>it&#39;s not too bad as long as the bandwith is low, as it would be the case with<br>
protocol traffic.<br>
<div class="Ih2E3d"><br>
&gt; - Most important: Nothing is better than end to end encryption /<br>
&gt; authentication / authorization.<br>
<br>
</div>that&#39;s true, but it doesn&#39;t help if the underlying mesh protocol can be<br>
disturbed easily by un-authenticated nodes and your traffic never reaches the<br>
other endpoint.<br>
<br>
there are two different layers of adding authentication and encryption. one is<br>
the mesh protocol itself the other one is end-to-end user encryption. both<br>
are necessary if you want to make your network secure.<br>
<font color="#888888"><br>
bruno<br>
</font><div><div></div><div class="Wj3C7c">_______________________________________________<br>
B.A.T.M.A.N mailing list<br>
<a href="mailto:B.A.T.M.A.N@open-mesh.net">B.A.T.M.A.N@open-mesh.net</a><br>
<a href="https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n" target="_blank">https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n</a><br>
</div></div></blockquote></div><br><br clear="all"><br>-- <br>Vinay Menon

------=_Part_1504_33105667.1207810786055--
