
/** Render checker for tests in python */

class QgsRenderChecker
{
%TypeHeaderCode
#include <qgsrenderchecker.h>
%End
  public:

    QgsRenderChecker();

    //! Destructor
    ~QgsRenderChecker();

    QString controlImagePath() const;

    QString report();
    float matchPercent();
    unsigned int mismatchCount();
    unsigned int matchTarget();
    //only records time for actual render part
    int elapsedTime();
    void setElapsedTimeTarget( int target );

    /** Base directory name for the control image (with control image path
     * suffixed) the path to the image will be constructed like this:
     * controlImagePath + '/' + mControlName + '/' + mControlName + '.png'
     */
    void setControlName( const QString &name );

    /** Prefix where the control images are kept.
     * This will be appended to controlImagePath
     */
    void setControlPathPrefix( const QString &name );

    void setControlPathSuffix( const QString &name );

    /** Get an md5 hash that uniquely identifies an image */
    QString imageToHash( const QString &imageFile );

    void setRenderedImage( const QString &imageFileName );

    /**
     * The path of the rendered image can be retrieved through that method.
     * Will return the path set with setRenderedImage() or generated in runTest()
     *
     * @return The path to the rendered image
     */
    QString renderedImage();

    //! @note added in 2.4
    void setMapSettings( const QgsMapSettings &mapSettings );

    /** Set tolerance for color components used by runTest() and compareImages().
     * Default value is 0.
     * @param colorTolerance is maximum difference for each color component
     * including alpha to be considered correct.
     * @note added in 2.1
     */
    void setColorTolerance( unsigned int colorTolerance );

    /** Sets the largest allowable difference in size between the rendered and the expected image.
     * @param xTolerance x tolerance in pixels
     * @param yTolerance y tolerance in pixels
     * @note added in QGIS 2.12
     */
    void setSizeTolerance( int xTolerance, int yTolerance );

    /**
     * Test using renderer to generate the image to be compared.
     * @param testName - to be used as the basis for writing a file to
     * e.g. /tmp/theTestName.png
     * @param mismatchCount - defaults to 0 - the number of pixels that
     * are allowed to be different from the control image. In some cases
     * rendering may be non-deterministic. This parameter allows you to account
     * for that by providing a tolerance.
     * @note make sure to call setExpectedImage and setMapRenderer first
     */
    bool runTest( const QString &testName, unsigned int mismatchCount = 0 );

    /**
     * Test using two arbitrary images (map renderer will not be used)
     * @param testName - to be used as the basis for writing a file to
     * e.g. /tmp/theTestName.png
     * @param mismatchCount - defaults to 0 - the number of pixels that
     * are allowed to be different from the control image. In some cases
     * rendering may be non-deterministic. This parameter allows you to account
     * for that by providing a tolerance.
     * @param renderedImageFile to optionally override the output filename
     * @note: make sure to call setExpectedImage and setRenderedImage first.
     */
    bool compareImages( const QString &testName, unsigned int mismatchCount = 0, const QString &renderedImageFile = "" );
    /** Get a list of all the anomalies. An anomaly is a rendered difference
     * file where there is some red pixel content (indicating a render check
     * mismatch), but where the output was still acceptable. If the render
     * diff matches one of these anomalies we will still consider it to be
     * acceptable.
     * @return a bool indicating if the diff matched one of the anomaly files
     */
    bool isKnownAnomaly( const QString &diffImageFile );

    /** Draws a checkboard pattern for image backgrounds, so that transparency is visible
     * without requiring a transparent background for the image
     */
    static void drawBackground( QImage *image );

    /**
     * Returns the path to the expected image file
     *
     * @return Path to the expected image file
     */
    QString expectedImageFile() const;

    /**
     * Call this to enable internal buffering of dash messages. You may later call
     * dashMessages() to get access to the buffered messages. If disabled (default)
     * dash messages will be sent immediately.
     *
     * @param enable Enable or disable buffering
     */
    void enableDashBuffering( bool enable );

    /**
     * Get access to buffered dash messages.
     * Only will return something if you call enableDashBuffering( true ); before.
     *
     * @return buffered dash messages
     * @note not available in python bindings
     */
    // const QVector<QgsDartMeasurement> &dartMeasurements() const;
};
