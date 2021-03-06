<?xml version="1.0" encoding="utf-8"?> 
<!-- ************************************************************************ -->
<!--                                     NLM STYLECHECKER
                                           Version 5.4
    
    Stylesheet tests an XML instance to determine whether it conforms to correct
    PMC style as defined in the Tagging Guidelines located at:
    
     For Journal Articles:
      http://www.pubmedcentral.nih.gov/pmcdoc/tagging-guidelines/article/style.html
     
     For Manuscripts:
      http://www.pubmedcentral.nih.gov/pmcdoc/tagging-guidelines/manuscript/style.html
        
    For Books
      http://www.pubmedcentral.nih.gov/pmcdoc/tagging-guidelines/book/style.html
     
    Output from this stylesheet will have the following structure:
      -<ERR> will be the root element
      -Content of ERR will be a copy of the input XML
      -Original DOCTYPE from input XML will be removed
      -<error> elements will be inserted near the point of any style errors that
       must be corrected
      -<warning> elements will be inserted near any content that looks
       suspicious; the tagging should be checked, but does not need
       to be changed to conform to PMC style
      -<error> and <warning> taggs will contain the name of the style test
        followed by a description of the error or warning
      
     The output can be run against style-reporter.xsl to make an HTML report.
     
     
     There are two Stylesheet-level parameters that may be passed into the
        stylechecker:
         
         style - this parameter describes the style that you wish to test
                 your file against. If no style parameter is declared. the 
                 stylechecker will use 'article'. Currently, the values are:
                    
                    manuscript - for nihms manuscript style
                    book - for book content in PMC
                    article - for published articles (this is the default)
                    
        editstyle - this is a parameter that is available to identify 
                 	  content that has been created with a MS Word XML authoring
                    program using Word Styles here at NCBI. Currently only the
                    value 'word' is recognized, and it is only being applied
                    to $style='book' content.
                    
     
     
     
   PMC Project Revision notes:
    February 10, 2014: Version 5.4
                        Public release of 1st quarter changes
   
    January 21, 2014:
    				Expanded xref-check to allow element [target] withing existing
    				  allowed structures to be a valid match
   
    December 23, 2013:
                     subj-group[@subj-group-type="heading"] cannot have a 
                       subject with only an <inline-grapic>
   
    December 3, 2013:
                    Added explicit test for @xml:lang on all trans-* elements

    December 2, 2013:
                    Add newer pub-date attributes specifying electronic collection to 
                      dup-pub-date-check
                      pub-date-check
                      pub-type-check
                      date-type-check
   
    November 25, 2013:
                    Modified license-ext-link-content-check to exclude strings that are
                    	likely sentences containing URIs.
   
    November 8, 2013: Version 5.3
                    Public release of 4th quarter changes
		
	October 31, 2013:
	 			Allowed <target> to be empty - to act as a milestone.
	
    September 25, 2013:
    			Added allowed values to ext-link-type:
    				bmrb, EBI:arrayexpress, ERI:ena, geneweaver:geneset
    			Allowed Winter-Spring as a range for <season>
    			In license//ext-link checking, do not allow multiple creativecommons.org/licenses
    				URI values in a single license
    
    September 4, 2013:
                   Allow related-object in lieu of related-article; related-object 
                   	now included in:
	                  article-type-to-related-article-check
	                  related-article-to-article-type-check
   
    August 16, 2013:
                   added "arxiv" as allowed value in template pub-id-type 
   
    August 12, 2013: Version 5.2
                    Public release of 3rd quarter changes                    
    July 16, 2013: 
                    Unescaped spaces will cause malformed DOI error    
    July 1, 2013:
                   Warn if count(abstract/sec)=1 and count(abstract/sec/sec) > 1
                   Warn if kwd-group has only 1 <kwd> which contains punctuation                    
    May 28, 2013: 
                    Empty element check on issue
                    Normalize space in math fence checks
                    
    May 10, 2013: Version 5.1
                    Public release of changes from 4/3/13, 3/1/13
    April 3, 2013: 
                    Added collection pub-type to dup-pub-date-check
    March 1, 2013: 
	               Added 'referee-report' to allowed related-article-type values
	               Removed abstract title test
   
   	January 15, 2013: Version 5.0
   					xref-type="list" may point to def element ("def" not allowed in Blue)
   					alternatives allowed in td, th
   					Allow single characters tagged as math
   					Enforce license integrity rules
   					tex-math must not include non-TeX entities
   					tex-math must include \begin{document} and \end{document}
   					collab must have content other than contrib-group
   					contrib-group//collab must not contain contrib-group
   					Formulas (disp or inline) must not have >1 mml:math, tex-math 
   						unless wrapped in alternatives
   					Updates for JATS 1.0:
	   					pub-date rules expanded to include new attributes:
	   						pub-date checks accommodate date-type + publication-format
	   						pub-date/@date-type must be recognized value
	   						pub-date/@publication-format must be print, electronic, or electronic-print
	   					compound-subject is not allowed in subj-group[@subj-group-type="heading"]
	   					contrib-id not allowed in contrib[collab]
	   					contrib must not have > 1 name, use name-alternatives
	   					In aff-, citation-, collab-, name-alternatives	   						
	   						children should specify either @xml:lang or @specific-use
	   						if children specify @xml:lang, exactly 1 must have same value as /article/@xml:lang
	   							including inherited values
	   						if children specify @specific-use, all must include it
	   						values of @xml:lang and @specific-use should be unique
	   						Variations:
	   						- in citation-alternatives, rules apply when > 1 of a given element 
	   							(element- or mixed-citation), not across all elements
	   						- in name-alternatives, name[@content-type="index"] is not included	   						
	   					If name has given-names only, @name-style must be specified
   
	April 6, 2011 - updated ext-link-type value testing for values documented in PMC Tagging
							 Guidelines. 

    	January 11, 2011: We no longer allow sec-type display-objects for version 3 manuscripts. Floating objects
                      must be contained in a floats-group
                      
   	August 25, 2010: Version 4.2.2
   					Allowed disp-formula-group as target of xref/@ref-type="disp-formula" and "chem"
   
     April 28, 2010: Version 4.2.0
     					When a pub-date has @pub-type="collection", the required pub-date @pub-type="epub" 
     						must have both day and month
     					Related article elements with @ext-link-type="pmc" must have either @vol and @page 
     						OR @vol and @elocation-id
     					Related article elements with @ext-link-type="pmc" should not have @xlink:href 
     						unless @xlink:href value is a PMCID
     					Manuscripts with @article-type="correction" may have subject "Correction" or "Errata"
     					Manuscripts with @article-type="retraction" may have subject "Retraction"
     					Manuscripts with @article-type="correction" or "retraction" must have related-article 
     
     June 23, 2009: Version 4.0.6
	 					Citation exceptions expanded to include new mixed- and element-citation						
						
	 June 16, 2009: Version 4.0.5
     					Attribute id is required on sub-article and response
     					Element alternatives must have more than 1 child
     						
	April 15, 2009: Version 4.0.4
					Contract-sponsor must have an rid attribute that points to contract-num;
						or rid attribute that points to contract-sponsor's @id; 
						or an id attribute
					Contract-num must link to contract-sponsor
   
	February 13, 2009: Version 4.0.3
						Allow trans-abstract in manuscript xml.
						
	November 25, 2008: Version 4.0.1
						Added rules to enforce PMC Tagging Style for <alternatives>

	November 23, 2008: Version 4.0
						Added rules to support PMC Tagging Style for documents using
						version 3.0 of the NLM Journal DTDs.
	
						Added a check to article-meta test in article mode to require 
						a pub-date of a type other than 'nihms-submitted'
						
						
		
	
	April 30, 2008:	Version 3.4	
						Fixed problem in stylecheck-named-tests that was reporting 
						hyphenated season values as style errors
	
	April 1, 2008
						removed requirement for contract-sponsor to have an id if there is 
					   no contract-num in the file
	
	March 5, 2008
					added some checks for MathML content:
						- expanded the check for single-character mathml to include 
						  grandchild of mml:math
						- added template "mathml-repeated-element-check" and tested
						  mml:mn and mml:mtext against it.
						  
						  mml:mn immediately followed by mml:mn is an error
						  mml:mtext immediately followed by mml:mtext is a warning

	 
	 February 26, 2008  Version 3.3
	 					added hhmipa as an allowed value for the origin PI
						cleaned up nonspecific match of text()
						in month-check, day-check, year-check, added 
						   $context/ancestor::nlm-citation to the exclusions

	 
	 January 25, 2008
	 					allowed 'alt-language' as a related-article-type	 
	 
	 
	 January 21,2008: Version 3.2
	 					Remove rule requiring only one of @corresp on <contrib> or
						  correspondence footnote.
						Related article does not require ext-link-type if there is 
						  no xlink:href. But it should still have an ID.
						  
	 
	 November 7, 2007: Version 3.1.4
	 							Allowed <notes> in <back> for the manuscript workflow.
	 
	 July 3, 2007: Added test to require <journal-meta>
	 
    May 2, 2007: Version 3.1.3
                        PMC Style change: Floating objects no longer have
                        to be in sec-type="display-objects"
                        Removed: floating-object-check
                        Added: floats-wrap-check                            
                            
                        allowed journal-id-type values 'pubmed-jr-id' and 
                            'nlm-journal-id'
                        Loosened math character check to test for ancestor
                            rather than just parent being a math element.   

     March 26, 2007: Version 3.1.2: Allows 'hwp' as a value for 
                          @journal-id-type.
     
     March 21, 2007: Version 3.1.1: No longer complains about xlink 
                     attributes on <contrib>
     
     February2007: Version 3.1: Some xsl errors fixed.
     
     February2007: Version 3.0: One stylechecker written for articles, 
                   manuscripts, and books.
     
    12/8/2005: Style checker redesigned so that it does not rely on
               extension functions
    2005-07-10: Set "." as default context param throughout.
  -->
<!-- ************************************************************************ -->


<xsl:stylesheet 
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
   xmlns:xlink="http://www.w3.org/1999/xlink" 
   xmlns:mml="http://www.w3.org/1998/Math/MathML" 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
   version="1.0">
   
   <xsl:output method="xml" 
       omit-xml-declaration="yes"
       encoding="UTF-8"
       indent="yes"/>

   <!-- ==================================================================== -->
   <!--
                                  INCLUDES
     -->
   <!-- ==================================================================== -->
   <xsl:include href="stylecheck-match-templates.xsl"/>
   <xsl:include href="stylecheck-helper-templates.xsl"/>
   <xsl:include href="stylecheck-named-tests.xsl"/>

 
   <!-- ==================================================================== -->
   <!--                                                                      -->
   <!--                        GLOBAL PARAMETERS                             -->
   <!-- ==================================================================== -->

   <!-- Name of the XML/NXML file being processed   -->
   <xsl:param name="filename"/>

   <!-- If "true" then output messages to standard error; do not if "false" -->
   <xsl:param name="messages" select="'false'"/>

   <!-- Consider the document-type to be the type-name of the root element. -->
   <xsl:param name="document-type" select="
      name(/child::node()[not(self::comment()) and 
                          not(self::processing-instruction()) and 
                          not(self::text())])"/>

   <!-- Indicate our own version -->
   <xsl:param name="stylechecker-version"     select="'5.0'"/>
   <xsl:param name="stylechecker-mainline"    select="'nlm-stylechecker5.xsl'"/>

   <!-- The 'style' selects the rules that can be applied by the stylechecker.
        However, it is not used directly except to set $stream, below.
            Values include:
                article - for articles (the default)
                manuscript - for manuscripts
                book - for book content  
     -->
	<xsl:param name="style">
		<xsl:choose>
			<xsl:when test="name(/*)='book-part' or name(/*)='book'">
				<xsl:text>book</xsl:text>
            </xsl:when>
			<!-- How can we sniff for a manuscript? -->
			<xsl:when test="//processing-instruction('nihms')">
				<xsl:text>manuscript</xsl:text>
            </xsl:when>
			<!-- How can we sniff for a Rapid Research Note? -->
			<xsl:when test="contains(//processing-instruction('properties'),'RRN')">
				<xsl:text>rrn</xsl:text>
            </xsl:when>
			<xsl:otherwise>
				<xsl:text>article</xsl:text>
            </xsl:otherwise>
			</xsl:choose>
		</xsl:param>	   


   <!-- When $editstyle='word', that means it's a book that was converted from
        an MS Word(tm) document. -->
	<xsl:param name="editstyle">
		<xsl:variable name="flag">wordconverted='yes'</xsl:variable>
		<xsl:if test="contains(string(/processing-instruction('metadata')),$flag)">word</xsl:if>
		</xsl:param>

	<xsl:param name="stream">
		<xsl:choose>
			<xsl:when test="$style='manuscript' or
                         $style='book'">
				<xsl:value-of select="$style"/>
				</xsl:when>
			<xsl:when test="$style='article'">
				<xsl:text>article</xsl:text>
				</xsl:when>
			<xsl:when test="$style='rrn'">
				<xsl:text>rrn</xsl:text>
				</xsl:when>
			<xsl:otherwise> 
				<!-- error, but try to recover -->
				<xsl:text>article</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>

    
	<xsl:param name="content-title">
		<xsl:value-of select="/book/book-meta/book-title-group/book-title"/>
		<xsl:value-of select="/book-part/book-part-meta/title-group/title"/>
		<xsl:value-of select="/article/front/article-meta/title-group/article-title"/>
		</xsl:param>

	<xsl:param name="dtd-version">
		<xsl:variable name="attvalue" select="substring-before(/node()/@dtd-version,'.')"/>
		<xsl:choose>
			<xsl:when test="not(/node()/@dtd-version)"> and unknown version </xsl:when>
			<xsl:when test="$attvalue='1' and /article/front/journal-meta/journal-title-group">j1</xsl:when>
			<xsl:when test="$attvalue='3'">3</xsl:when>
			<xsl:when test="$attvalue='2' or $attvalue='1'">2</xsl:when>
			<xsl:otherwise>[<xsl:value-of select="/node()/@dtd-version"/>||<xsl:value-of select="$attvalue"/>]</xsl:otherwise>
			</xsl:choose>
		</xsl:param>

	<xsl:param name="art-lang-att">
		<xsl:choose>
			<xsl:when test="/article/@xml:lang">
				<xsl:call-template name="knockdown">
					<xsl:with-param name="str" select="/article/@xml:lang"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="/book-part/@xml:lang">
				<xsl:call-template name="knockdown">
					<xsl:with-param name="str" select="/book-part/@xml:lang"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="/book/@xml:lang">
				<xsl:call-template name="knockdown">
					<xsl:with-param name="str" select="/book/@xml:lang"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>en</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:param>


   <!-- ********************************************************************* -->
   <!-- Template: / 
        
        Process all children of the document root 
     -->
   <!-- ********************************************************************* -->
	<xsl:template match="/">
		<ERR>
			<xsl:processing-instruction name="SC-DETAILS">
				<xsl:if test="$stream != $style">
					<xsl:text>******* ERROR: $style WAS NOT PASSED CORRECTLY *******</xsl:text>
			   	</xsl:if>
				<xsl:text>Style checking applied for document with the root element "</xsl:text>
				<xsl:value-of select="$document-type"/>
				<xsl:text>"  with version </xsl:text>
				<xsl:value-of select="$stylechecker-version"/>
				<xsl:text> of the NLM XML StyleChecker. </xsl:text>
				<xsl:text>||</xsl:text>
				<xsl:text>The document is being checked against the PMC Tagging Guidlines rules for "</xsl:text>
				<xsl:value-of select="$stream"/>
				<xsl:text>" for content tagged using </xsl:text>
				<xsl:choose>
					<xsl:when test="$dtd-version='2'">
						<xsl:text> version 2.3 or earlier </xsl:text>
						</xsl:when>
					<xsl:when test="$dtd-version='3'">
						<xsl:text> version 3.0 </xsl:text>
					</xsl:when>
					<xsl:when test="$dtd-version='j1'">
						<xsl:text> version 1.0 </xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$dtd-version"/>
						</xsl:otherwise>
					</xsl:choose>
				<xsl:text>of the </xsl:text>
				<xsl:choose>
					<xsl:when test="$dtd-version='j1'">
						<xsl:text>JATS DTD. </xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>NLM DTD. </xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text>||</xsl:text>
				<xsl:text> The document was tagged with the language attribute value "</xsl:text>
				<xsl:value-of select="$art-lang-att"/>
				<xsl:text>". </xsl:text>
				</xsl:processing-instruction>
			<xsl:processing-instruction name="TITLE">
				<xsl:value-of select="$content-title"/>
				</xsl:processing-instruction>
			<xsl:apply-templates/>
		</ERR>
		</xsl:template>

</xsl:stylesheet>
