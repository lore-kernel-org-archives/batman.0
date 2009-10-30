Return-Path: <onelektra@gmx.net>
From: elektra <onelektra@gmx.net>
Date: Fri, 30 Oct 2009 13:11:58 +0100
References: <4AA34865.9000203@rsm-freilassing.de>
	<200909090157.53099.lindner_marek@yahoo.de>
	<4AEABDBB.2010704@rsm-freilassing.de>
In-Reply-To: <4AEABDBB.2010704@rsm-freilassing.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200910301311.58924.onelektra@gmx.net>
Subject: Re: [B.A.T.M.A.N.] Problems with Gateway-Selection without option -g
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

Hello Michael -

> i do not like to use the -g option, to select the preffered gateway. I
> need a complete route-information.
> 
> I'm not able to set the HNA-Route 0.0.0.0/0 because a error-message
> appears: Invalid announced network (netmask is invalid): 0.0.0.0/0
> The current workarround is, to set HNA-Routes for 0.0.0.0/1,128.0.0.0/1.
> 
> Is there a chance, that anyone make a patch to add a new option to
> "batmand"-command, to allow /0 routes?
> 
> The -g option should be disabled, in case the /0-option is enabled.

*sigh*

This question has been raised and discussed before. Should become part of a 
FAQ list. Check the mailing list archive. In 99.9% of the cases it is stupid 
to announce /0.  Since the project is open source you or anyone else can 
modify the code and maintain a patch, for those who think it is smart to have 
this "feature". I would consider it a bug.  

Cheers,
Elektra
